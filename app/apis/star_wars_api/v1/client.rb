module StarWarsApi
  module V1
    class Client
      BASE_URL = 'https://swapi.dev/api'.freeze

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
        # Oj.load(response.body)
      end
    end
  end
end
