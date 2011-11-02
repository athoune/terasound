require "minitest/autorun"
require "terasound/riak"

describe "Terasound" do
  it "puts mp3 to the server" do
    f = Terasound::Riak.new
    EM.run do
      p = f.upload_file("spec/test.mp3", "terasound3", "audio/mpeg", {beuha: "aussi"}) do
        EM.stop
      end
    end
  end
end
