module Arctic
  module UI
    class Configuration
      attr_accessor :client_id, :client_secret, :url, :scope, :cache

      def initialize
        self.client_id ||= 'f39374d3899c393fb9362b07587b9a4ba3c50c534325ed15b8d0d86f146b2067'
        self.client_secret ||= 'a049351f24fb10e0534e3602b11aa073bf8ab5ed05552bbee040956abeda3c5d'
        self.url ||= 'http://localhost:5000/v1'
        self.scope ||= 'ui account:read account:update shops:read shops:create'
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
