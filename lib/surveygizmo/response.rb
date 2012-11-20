require 'hashie'
module Surveygizmo
  class Response
    attr_reader :response
    attr_reader :data

    class << self
      attr_accessor :mash_class
    end

    self.mash_class = Hashie::Mash

    def initialize(response)
      @response = mashify(response)
      @data     = @response.data
    end

    def method_missing(name, *arguments, &block)
      @data.send(name, *arguments, &block)
    end

    # Build meta data access methods.
    [:total_count, :page, :total_pages, :results_per_page].each do |field|
      define_method field do
        @response.send(field).to_i
      end
    end

    def success?
      @response.result_ok
    end

    def ==(other)
      (self.data == other.data) && (self.result == other.result)
    end

    def mashify(body)
      self.class.mash_class.new(body)
    end
  end
end