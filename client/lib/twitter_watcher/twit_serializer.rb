module TwitterWatcher
  class TwitSerializer

    def initialize(status)
      @status = status
    end

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
