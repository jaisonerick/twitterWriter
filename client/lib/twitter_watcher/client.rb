require 'tweetstream'

module TwitterWatcher
  class Client
    attr_reader :stream

    def initialize
      @stream = TweetStream::Client.new
    end

    def start
      @stream.on_limit do |skip_count|
        puts "Skipping..... #{skip_count}"
      end
      @stream.on_error do |error|
        puts "Error... #{ error }"
      end
    end

    def track_string(topics, &block)
      topics = topics.split(' ')
      track(topics, &block)
    end

    def track(topics, &block)
      @stream.track(*topics) do |status|
        block.call status
      end
    end

  end
end
