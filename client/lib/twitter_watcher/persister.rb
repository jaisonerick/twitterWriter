require 'sidekiq'
require 'rest-client'
require 'twitter_watcher/twit_serializer'
require 'twitter_watcher/api'

module TwitterWatcher
  class Persister
    include Sidekiq::Worker

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
