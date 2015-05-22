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
