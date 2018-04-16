module Arctic
  module UI
    class Configuration
      attr_accessor :client_id, :client_secret, :url, :scope, :cache

      def initialize
        self.client_id ||= '2e088d752d61c023fbc91ca6c585a978a030187c4a18fbfb34ea39d78ef3c6a2'
        self.client_secret ||= '3675b0433b39d93eff54921e45c948c42ed13df8425d9f686a038de7685d30e0'
        self.url ||= 'http://localhost:5000/v1'
        self.scope ||= 'ui account:read account:update shops:read'
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
