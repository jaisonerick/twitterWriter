require 'twitter_watcher/persister'

module TwitterWatcher
  class Consumer

    def initialize(client)
      @client = client
    end

    def consume(topic)
      @client.track_string(topic) do |status|
        puts "[#{ Time.now.getlocal }] #{ status.created_at.getlocal } From @#{ status.user.screen_name } "
        "at #{ status.user.location }"
        Persister.perform_async status.to_hash
      end
    end

  end
end
