ENV['RACK_ENV'] ||= 'development'

require 'uri'
require 'faraday'
require 'oauth2'
require 'faraday_middleware'
require 'faraday-http-cache'

module Arctic
  module Core
    class API
      attr_reader :connection

      def initialize(username, password)
        bearer_token = authenticate!(username, password).token

        # Construct connection object
        @connection = Faraday.new(Arctic::Core.configuration.url) do |conn|
          conn.request :oauth2, bearer_token, token_type: :bearer
          conn.request :json

          conn.response :json

          # If there's a http cache configured, use it
          if Arctic::Core.configuration.cache
            conn.use :http_cache, store: Arctic::Core.configuration.cache
          end

          conn.adapter Faraday.default_adapter
        end

        # Add Client ID to al l requests
        connection.headers['ClientId'] = Arctic::Core.configuration.client_id
      end

      def method_missing(name, *args)
        method = name.to_s.gsub /(get|update|create)_/, 'ui/'

        response = case name.to_s.downcase
          when /get_/ then connection.get method, *args
          when /update_/ then connection.patch method, *args
          when /create_/ then connection.post method, *args
          else super name, *aths
          end

        response.body
      end

      private

        def authenticate!(username, password)
          client = OAuth2::Client.new \
            Arctic::Core.configuration.client_id,
            Arctic::Core.configuration.client_secret,
            {
              site: Arctic::Core.configuration.url,
              token_url: 'oauth/token',
            }

          client.password.get_token \
            username,
            password,
            {
              scope: Arctic::Core.configuration.scope,
            }
        end
    end
  end
end
