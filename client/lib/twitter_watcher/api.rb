require 'rest-client'

module TwitterWatcher
  module Api
    class Configuration
      attr_accessor :base_url

      def initialize
        @base_url = 'http://localhost:3000'
      end
    end

    extend self

    CONFLICT = 409
    UNPROCESSABLE_ENTITY = 422

    attr_accessor :configuration

    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    def create_twit(twit)
      RestClient.post configuration.base_url + '/twits',
                      { twit: twit }.to_json,
                      content_type: :json,
                      accept: :json
    end
  end
end
