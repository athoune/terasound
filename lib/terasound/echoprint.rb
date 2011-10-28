require "json"

module TeraSound

  # Parse a folder and extract mp3 data
  def TeraSound.codegen path, &block
    Dir["#{path}/**/*.mp3"].each do |mp3|
      yield JSON.parse(`echoprint-codegen "#{mp3}" 10 30`)[0]
    end
  end

end
