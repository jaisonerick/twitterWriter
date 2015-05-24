require 'tweetstream'

module TwitterWatcher
  # Wrap Twitter communication
  class Client

    # Creates the Twitter adapter
    def initialize
      @stream = TweetStream::Client.new
    end

    # Start listening to the given topics by string. In this case the topic
    # can be separated by spaces, like: 'obama dilma'. Listen to the Twits using a block
    # that receives the Tweet object.
    def track_string(topics, &block)
      topics = topics.split(' ')
      track(topics, &block)
    end

    # Start listening to the given topics by array. In this case the topic
    # is an array of topics, like: ['obama', 'dilma']. Listen to the Twits using a block
    # that receives the Tweet object.
    def track(topics, &block)
      @stream.track(*topics) do |status|
        block.call status
      end
    end

  end
end
