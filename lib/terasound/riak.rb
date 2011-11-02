require 'em-http-request'
require 'json'

module Terasound
  class Riak
    def initialize(host = 'localhost', port=8098)
      @conn = EventMachine::HttpRequest.new("http://#{host}:#{port}")
    end

    def bucket(bucket, &block)
      req = @conn.put(
        path: "/riak/#{bucket}",
        keepalive: true,
        body: {props: {n_val: 1}}.to_json,
        head: {"Content-Type" => "application/json"}
      )
    end

    def upload_code(code, bucket)
      head = {"Content-Type" => "text/plain"}
      @conn.post(
        path: "/riak/#{bucket}",
        keepalive: true,
        body: code,
        head: head
      )
    end

    def upload_file(filepath, bucket, contentType, metadata={}, &block)
      code = upload_code(metadata['code'], bucket)

      code.callback do
        if code.response_header.status == 201
          key = code.response_header['LOCATION'].split('/')[3..-1].join('/')
          head = {
            "Content-Type" => contentType,
            "link" => "</#{key}>; riaktag=\"code\""
          }
          metadata.map do |k, v|
            #head["X-Riak-Index-#{k}"] = v
            head["X-Riak-Meta-#{k}"] = v.to_s if v != nil and v != ""
          end
          req = @conn.post(
            path: "/riak/#{bucket}",
            keepalive: true,
            file: filepath,
            head: head
          )
          req.errback do
            puts "argh, can't upload", req
            puts req.response_header
            puts req.response_header.status
            puts req.response
          end
          req.callback do
            yield block
          end
        end
      end
    end

  end
end
