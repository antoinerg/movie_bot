module MovieBot
  class Error < ::StandardError
    attr_accessor :wrapped_exception
  end
  
  class IMDBNotFound < Error; end;
end