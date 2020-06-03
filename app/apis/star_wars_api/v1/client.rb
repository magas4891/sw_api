module StarWarsApi
  module V1
    class Client
      include HttpStatusCodes
      include ApiExceptions

      BASE_URL = 'https://swapi.dev/api'.freeze
      API_REQUSTS_QUOTA_REACHED_MESSAGE = 'API rate limit exceeded'.freeze

      def root_request
        request(
            'get',
            '/'
        )
      end

      def get_peoples
        request(
          'get',
          '/people/'
        )
      end

      def show_people(id)
        request(
            'get',
            "/people/#{id}/"
        )
      end

      def get_films
        request(
            'get',
            '/films/'
        )
      end

      def show_film(id)
        request(
            'get',
            "/films/#{id}/"
        )
      end

      def get_starships
        request(
            'get',
            '/starships/'
        )
      end

      def show_starship(id)
        request(
            'get',
            "/starships/#{id}/"
        )
      end

      def get_vehicles
        request(
            'get',
            '/vehicles/'
        )
      end

      def show_vehicle(id)
        request(
            'get',
            "/vehicles/#{id}/"
        )
      end

      def get_species
        request(
            'get',
            '/species/'
        )
      end

      def show_species(id)
        request(
            'get',
            "/species/#{id}/"
        )
      end

      def get_planets
        request(
            'get',
            '/planets/'
        )
      end

      def show_planet(id)
        request(
            'get',
            "/planets/#{id}/"
        )
      end

      private

      def request(http_method, url)
        connection = Faraday.new(BASE_URL + url)
        response = connection.send(http_method)
        parsed_response = Oj.load(response.body)

        return parsed_response if response_successful?(response)

        raise error_class(response), "Code: #{response.status}, response: #{response.body}"
      end

      def error_class(response)
        case response.status
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          return ApiRequestsQuotaReachedError if api_requests_quota_reached?(response)
          ForbiddenError
        when HTTP_NOT_FOUND_CODE
          NotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        else
          ApiError
        end
      end

      def response_successful?(response)
        response.status == HTTP_OK_CODE
      end

      def api_requests_quota_reached?(response)
        response.body.match?(API_REQUSTS_QUOTA_REACHED_MESSAGE)
      end
    end
  end
end
