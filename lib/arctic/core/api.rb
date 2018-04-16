ENV['RACK_ENV'] ||= 'development'

require 'uri'
require 'faraday'

module Arctic
  module Core
    class API
      # Fetch all shops based on the account_id
      def self.shops(account_id)
        response = make_request :get, "preprocessors/accounts/#{account_id}/shops"
        JSON.parse(response.body).deep_symbolize_keys
      end

      # Update a batch of products
      def self.update_products(account_id, shop_id, products)
        responses = products.in_groups_of(1000, false).collect do |batch|
          make_request :patch, "preprocessors/accounts/#{account_id}/shops/#{shop_id}/products", { products: batch }
        end
        respond_to_batch responses
      end

      # Create a batch of products
      def self.create_products(account_id, shop_id, products)
        responses = products.in_groups_of(1000, false).collect do |batch|
          make_request :post, "preprocessors/accounts/#{account_id}/shops/#{shop_id}/products", { products: batch }
        end
        respond_to_batch responses
      end

      def self.make_request(method, path, body = nil)
        url = "#{Arctic::Core.configuration.url}/#{path}"
        Faraday.public_send(method, url) do |r|
          r.headers['Authorization'] = "Preprocessor #{ENV.fetch('CORE_KEY', 'NO_CORE_KEY')}"
          r.headers['Content-Type'] = 'application/json'
          r.headers['Accept'] = 'application/json'
          r.body = body.to_json if body
        end
      end

      def self.respond_to_batch(responses)
        responses.collect do |response|
          json = JSON.parse(response.body).deep_symbolize_keys
          if response.status != 202
            throw json[:error]
          else
            json[:job][:id]
          end
        end
      end
    end
  end
end
