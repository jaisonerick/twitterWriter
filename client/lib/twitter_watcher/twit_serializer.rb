module TwitterWatcher
  # Transform a Twitter hash into an API Twit json
  class TwitSerializer

    # Creates a new TwitSerializer. Receive a Twitter hash
    def initialize(status)
      @status = status
    end

    # Overrides the to_json method. Returns an API understandable Twit json
    def to_json(*args, &block)
      {
        twit_date: @status['created_at'],
        origin_id: @status['id'],
        body: @status['text'],
        author: {
          twitter_id: @status['user']['id'],
          screen_name: @status['user']['screen_name'],
          name: @status['user']['name'],
        }
      }.to_json(*args, &block)
    end
  end
end
