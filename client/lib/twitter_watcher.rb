$:.unshift File.dirname(__FILE__)

require 'twitter_watcher/cli'
require 'sidekiq'
require 'tweetstream'

module TwitterWatcher

  # Setup and starts the TwitterWatcher application.
  module Application
    extend self

    # Start the CLI application.
    # Handles the INT signal (ctrl+c) to stop the program.
    def start
      setup

      Signal.trap('INT') {
        puts "Quiting..."
        exit(0)
      }

      Cli.start(ARGV)
    end

    # Do general configuration on the application.
    def setup
      validate_env
      setup_sidekiq
      setup_twitter
      setup_api
    end

    # Configure the API connection
    def setup_api
      Api.configure do |config|
        config.base_url = 'http://localhost:8080'
      end
    end

    # Configure the TwitterStream connection
    def setup_twitter
      TweetStream.configure do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.oauth_token         = ENV['TWITTER_OAUTH_TOKEN']
        config.oauth_token_secret  = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      end
    end

    # Configure Sidekiq
    def setup_sidekiq
      Sidekiq.configure_server do |config|
        config.redis = { namespace: 'twitter' }
      end

      Sidekiq.configure_client do |config|
        config.redis = { namespace: 'twitter', size: 1 }
      end
    end

    # Check if required environment variables are defined. These are:
    # - TWITTER_CONSUMER_KEY
    # - TWITTER_CONSUMER_SECRET
    # - TWITTER_OAUTH_TOKEN
    # - TWITTER_OAUTH_TOKEN_SECRET
    def validate_env
      required_env = %w(TWITTER_CONSUMER_KEY TWITTER_CONSUMER_SECRET TWITTER_OAUTH_TOKEN TWITTER_OAUTH_TOKEN_SECRET)
      required_env.each do |env_name|
        unless ENV[env_name]
          raise ArgumentError, "Environment '#{env_name}' must be set"
        end
      end
    end
  end
end
