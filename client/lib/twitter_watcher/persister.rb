require 'sidekiq'
require 'rest-client'
require 'twitter_watcher/twit_serializer'
require 'twitter_watcher/api'

module TwitterWatcher
  # Send the Twit to the server
  class Persister
    include Sidekiq::Worker

    # Receive a hashed Twitter object and send it to the api, to create a new twit. Uses the
    # TwitSerializer class to transform the Twitter hash into an API understandable Twit json.
    # If the API returns a CONFLICT or UNPROCESSABLE_ENTITY response, just ignore and keep going.
    # Any other error will be logged into the Sidekiq process, that will retry later.
    def perform(status)
      begin
        Api.create_twit(TwitSerializer.new(status))
      rescue RestClient::Exception => e
        unless [Api::CONFLICT, Api::UNPROCESSABLE_ENTITY].include?(e.response.code)
          raise
        end
      end
    end
  end
end
