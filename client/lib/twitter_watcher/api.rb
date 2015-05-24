require 'rest-client'

module TwitterWatcher
  # Wraps the communication with the server
  module Api

    # Utility to configure API connection
    class Configuration
      attr_accessor :base_url

      def initialize
        @base_url = 'http://localhost:3000'
      end
    end
    extend self

    # HTTP status code constants
    CONFLICT = 409
    UNPROCESSABLE_ENTITY = 422

    attr_accessor :configuration

    # Setup the API:
    #
    #   Api.configure do |config|
    #     config.base_url = 'http://example.org'
    #   end
    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    # Send a new twit to the API.
    def create_twit(twit)
      RestClient.post configuration.base_url + '/twits',
                      { twit: twit }.to_json,
                      content_type: :json,
                      accept: :json
    end
  end
end
