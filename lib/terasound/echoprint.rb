require "json"

module TeraSound

  def TeraSound.codegen path
    JSON.parse `find #{path} -name "*.mp3" | echoprint-codegen -s 10 30`
  end

end
