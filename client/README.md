# TwitterWatcher - Client

This application is intended to work with TwitterWatcher - Server.

Using this application you'll receive realtime twits, filtered by the topic
you want and persist the to database, through the server application.

## Dependencies

* bundler: `gem install bundler`

## Installing

```bash
$> git clone git@github.com:jaisonerick/twitterwatcher.git && cd twitterwatcher
$> bundle install
```

You also must setup four environment variables:

* TWITTER_CONSUMER_KEY
* TWITTER_CONSUMER_SECRET
* TWITTER_OAUTH_TOKEN
* TWITTER_OAUTH_TOKEN_SECRET

## Getting Started

To start gathering twits, you'll need to run two applications:

* **Twitter** to search twits and append to the queue
* **Sidekiq** to to process the queue and send the twits to the server

If you want to to find what they are saying about **audi** and **bwm**, you can use the following command:

```bash
bin/twitter search "audi bmw"
```

It'll find twits that has one of theses words (not necessarily both in the same one). To stop, press <kbd>ctrl</kbd> + <kbd>C</kbd>

To start processing the queue, run **Sidekiq**:

```bash
bin/sidekiq -r ./workers/twitter.rb
```

It'll fetch the twits from the database and send them to the server. To stop, press <kbd>ctrl</kbd> + <kbd>C</kbd>

## Monitoring

You can monitor your queue using the Sidekiq built-in monitor:

```bash
bin/monitor
```

It'll start a server at **http://localhost:9494**.

## Design details

This application makes use of a distributed architecture. There are two main services: a consumer and a persister.

The consumer is running through the **bin/twitter** app. Its responsibility is to hear the twitter stream and put every
new twit in a Sidekiq queue to be treated later.  To hear twitter, it uses the TwitterStream gem. It uses the Thor gem
to handle the command line interface. It uses a TwitterWatcher module to setup the application, setting up the environment,
the TwitterStream and the Sidekiq gems.

Calling TwitterWatcher::start will start a Thor application, which is served by the TwitterWatcher::Cli class. To reduce
coupling between this system and the TwitterStream gem, there is a facade at TwitterWatcher::Client. The Consumer class
uses the Client and for each twit that it receives, it print the date and who did it, and add to the queue.

The Persister is responsible to process the Sidekiq queue and the the Twits data to the server through a POST request
to /twits. It'll use the TwitSerializer to transform the Twitter original data into a API understandable data. The
Persister then calls the Api class, passing the TwitSerializer to the create_twit method. The API uses the RestClient
gem to communicate.