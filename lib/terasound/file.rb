require 'em-http-request'
require 'json'

module Terasound
  class File
    def initialize(host = 'localhost', port=8098)
      @conn = EventMachine::HttpRequest.new("http://#{host}:#{port}")
    end

    def bucket(bucket, &block)
      req = @conn.put path: "/riak/#{bucket}", keepalive: true, body: {props: {n_val: 1}}.to_json, head: {"Content-Type" => "application/json"}
   end

    def put(filepath, bucket, metadata={})
      head = {"Content-Type" => "audio/mpeg"}
      metadata.map do |k, v|
        #head["X-Riak-Index-#{k}"] = v
        head["X-Riak-Meta-#{k}"] = v
      end
      req = @conn.post path: "/riak/#{bucket}", keepalive: true, file: filepath, head: head
      req.errback do
        puts "argh, can't upload", req
        puts req.response_header
        puts req.response
       end
      req
    end

  end
end
