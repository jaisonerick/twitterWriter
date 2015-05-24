require 'thor'
require 'twitter_watcher/client'
require 'twitter_watcher/consumer'

module TwitterWatcher
  # The Thor Cli Application
  class Cli < Thor

    # Start the consumer and client then consume a provided term.
    # The term can be separated by spaced, like: 'obama dilma'
    desc 'search TOPIC', 'find tweets mentioning the provided topic(s)'
    def search(term)
      @consumer = Consumer.new(Client.new)
      @consumer.consume(term)
    end
  end

end