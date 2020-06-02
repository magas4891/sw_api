module StarWarsApi
  module V1
    class Client
      API_ENDPOINT = 'https://swapi.dev/api/'.freeze

      def get_peoples
        
      end

      private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
        end
      end

      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, API_ENDPOINT + endpoint, params)
        Oj.load(response.body)
      end
    end
  end
end
