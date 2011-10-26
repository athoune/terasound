require "minitest/autorun"
require "terasound/file"

describe "Terasound" do
  it "puts mp3 to the server" do
    f = Terasound::File.new
    EM.run do
      p = f.put("spec/test.mp3", "terasound3", {beuha: "aussi"})
      p.callback do
        puts p.response_header
        puts p.response
        puts "uploaded"
        EM.stop
      end
    end
  end
end
