ENV['RACK_ENV'] ||= 'development'

require 'uri'
require 'faraday'

module Arctic
  module Core
    class API
      # Fetch all shops based on the account_id
      def self.shops(account_id)
        format_response make_request :get, "preprocessors/accounts/#{account_id}/shops"
      end

      # Updaet a single product
      def self.update_product(account_id, shop_id, product)
        product_id = URI.escape product[:id]
        body = {
          product: product,
        }

        make_request :patch, "preprocessors/accounts/#{account_id}/shops/#{shop_id}/products/#{product_id}", body
      end

      def self.make_request(method, path, body = nil)
        url = "#{Arctic::Core.configuration.url}/#{path}"

        response = Faraday.public_send(method, url) do |r|
          r.headers['Authorization'] = "Preprocessor #{ENV.fetch('CORE_KEY', 'NO_CORE_KEY')}"
          r.headers['Content-Type'] = 'application/json'
          r.headers['Accept'] = 'application/json'
          r.body = body.to_json if body
        end

        format_response response
      end

      def self.format_response(r)
        r.body.deep_symbolize_keys
      end
    end
  end
end
