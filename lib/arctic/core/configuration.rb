module Arctic
  module Core
    class Configuration
      attr_accessor :token, :url

      def initialize
        self.url ||= 'http://localhost:5000/v1'
      end
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
