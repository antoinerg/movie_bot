require 'yaml'
require 'mediainfo'

Mediainfo.xml_parser = "nokogiri"

module MovieBot
  class VideoFile
    VIDEO_EXT = YAML.load(File.read(File.join(File.dirname(__FILE__),"strings.yaml")))["extensions"]
    def initialize(path)
      @path = path.is_a?(Pathname) ? path : Pathname.new(paht)
    end
    
    def self.find_all(path)
      video = path.children.keep_if do |entry|
        VIDEO_EXT.include?(entry.extname)
      end
      raise VideoNotFound if video.empty?
      return video.collect {|v| VideoFile.new(v) }
    end
    
    def file
      @path
    end
    
    def info
      @info ||= Mediainfo.new(@path.realpath)
    end
    
    def dvd?
      @path.extname == '.iso'
    end
  end
end