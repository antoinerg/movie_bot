module MovieBot
  class MovieFolder
    # Initialize object and check whether the folder exist?
    def initiliaze(path)
      raise ArgumentError, 'Folder does not exists' unless Dir.exists?(path)
      @path = Pathname.new(path)
    end


  end
end
