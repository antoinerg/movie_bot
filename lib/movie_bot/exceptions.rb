module MovieBot
  class Error < ::StandardError
    attr_accessor :wrapped_exception
  end
  
  class ImdbIDNotFound < Error; end;
  class NfoNotFound < Error; end;
  class MovieNfoNotFound < Error; end;
  class VideoNotFound < Error; end;
  class BadFolderStructure < Error; end;
end