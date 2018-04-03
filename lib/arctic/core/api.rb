require "faraday"
require 'faraday_middleware'
require 'faraday_middleware/parse_oj'

module Arctic
  module Core
    class << self
      %i(get post).each do |verb|
        define_method verb do |endpoint, json: {}, params: {}|
          API.connection.public_send(verb) do |req|
            req.url endpoint
            req.body = json.to_json if json.any?
            params.each { |k, v| req.params[k] = v } if params.any?
          end
        end
      end
    end

    class API
      def self.connection
        @connection ||= Faraday.new(url: Arctic::Core.configuration.url) do |connn|
          connn.request :json
          connn.request :oauth2, Arctic::Core.configuration.token

          connn.response :logger # log requests to STDOUT
          connn.response :oj

          connn.adapter Faraday.default_adapter  # make requests with Net::HTTP
        end
      end
    end
  end
end
