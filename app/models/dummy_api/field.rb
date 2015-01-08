module DummyApi
  class Field
    attr_reader :options

    def initialize(options = nil)
      @options = options
    end

    def value
      faker_class.send(faker_method)
    end

    private

    def faker_class
      raise 'faker_class not implemented'
    end

    def faker_method
      raise 'faker_method not implemented'
    end
  end
end

