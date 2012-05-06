require 'yaml'
require 'mediainfo'

module MovieBot
  class VideoFile
    VIDEO_EXT = YAML.load(File.read(File.join(File.dirname(__FILE__),"strings.yaml")))["extensions"]
    def initialize(path)
      @path = path.is_a?(Pathname) ? path : Pathname.new(path)
    end
    
    def self.find_all(path)
      video=Array.new
      path.find do |entry|
        video << entry if
        # Look for file with right extension
        VIDEO_EXT.include?(entry.extname) ||
        # Look for a folder named VIDEO_TS
        is_dvd_folder?(entry)
      end 
      raise VideoNotFound if video.empty?
      return video.collect {|v| VideoFile.new(v) }
    end
    
    def path
      @path
    end
    
    def info
      if is_dvd_image?
        # Open the image and read info
      elsif is_dvd_folder?
        # Go read the right file in the folder
      else
        # Just read the file directly
        @info ||= Mediainfo.new(@path.realpath)
      end
      return @info
    end
    
    def dvd?
      # If its an iso
      self.class.is_dvd_image?(@path) || 
      # If its a VIDEO_TS folder
      self.class.is_dvd_folder?(@path)
    end
        
    def self.is_dvd_folder?(entry)
      (entry.basename.to_s == 'VIDEO_TS' && entry.directory?)
    end
    
    def is_dvd_folder?
      self.class.is_dvd_folder?(@path)
    end
    
    def self.is_dvd_image?(entry)
      entry.extname == '.iso'
    end
    
    def is_dvd_image?
      self.class.is_dvd_folder?(@path)
    end
  end
end