require 'twitter_watcher/persister'

module TwitterWatcher
  # Listen to a given topic and pass it through a persister
  class Consumer

    # Receives the twitter client
    def initialize(client)
      @client = client
    end

    # Start consuming the given topic, as string. You can pass something like "dilma obama" and it'll
    # listen what anyone has to say about it and append to a queue that will process it later. It'll also
    # display some information about what is being done in the console.
    def consume(topic)
      @client.track_string(topic) do |status|
        puts "[#{ Time.now.getlocal }] #{ status.created_at.getlocal } From @#{ status.user.screen_name } "
        "at #{ status.user.location }"
        Persister.perform_async status.to_hash
      end
    end

  end
end
