require 'yaml'

module MovieBot
  class VideoFile
    VIDEO_EXT = YAML.load(File.read(File.join(File.dirname(__FILE__),"extensions.yaml")))
    def initialize(path)
      @path = path.is_a?(Pathname) ? path : Pathname.new(paht)
    end
    
    def self.find_all(path)
      video = path.children.keep_if do |entry|
        VIDEO_EXT.include?(entry.extname)
      end
      return video.collect! {|v| VideoFile.new(v) }
    end
    
    def file
      @path
    end
  end
end