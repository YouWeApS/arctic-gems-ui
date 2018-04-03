module Arctic
  module Core
    class Configuration
      attr_accessor :token
    end

    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end
  end
end
