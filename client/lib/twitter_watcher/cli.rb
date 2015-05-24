require 'thor'
require 'twitter_watcher/client'
require 'twitter_watcher/consumer'

module TwitterWatcher
  class Cli < Thor

    desc 'search TOPIC', 'find tweets mentioning the provided topic(s)'
    def search(term)
      @consumer = Consumer.new(Client.new)
      @consumer.consume(term)
    end
  end

end