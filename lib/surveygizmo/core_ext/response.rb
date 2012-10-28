module Faraday
  class Response
    def ==(other)
      self.body == other.body
    end
  end
end