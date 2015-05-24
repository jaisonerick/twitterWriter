# TwitterWatcher - Server

Save Twits to the database and process analytical requests.

## Dependencies

* ruby: 2.2.2

## Installing

```bash
$> git clone git@github.com:jaisonerick/twitterwatcher.git && cd twitterwatcher/server
$> bundle install
```

## Getting Started

You can start the appplication with:

```bash
rails s
```

You can then use the TwitterWatcher Client application to start sending twits to the server. After receive a number
of Twits, you can start analyzing your results.

### By user

To find the most active user since you started gathering Twits, you can run the following rake task:

```bash
rake twitter:by_user
```

It'll return the twitter name of the user, and the number of twits her did.

### By time

Another option is to see what hour was the most active among all your Twits. To find out, run:

```bash
rake twitter:by_time
```

You'll receive the number of the twits of each hour.

## Design details

Even thought this is a simple application, there are some complications in the way. To insert a Twit, you must known the
user who did it. The RESTful convention would be to create two routes: POST /twits and POST /author, so the client would
first call the second to add the Author, and then call the first to add the Twit, specifying who the author was. It would
be cleaner from the server application, which wouldn't have to encapsulate all the logic in just one action, but for the
client it would mean two requests, instead of one.

Beyond that, it is important to keep the code as simple as possible. Since there was no way to get the author_id, it
makes no sense to allow the user to create a twit just by send the author_id (without any author details).

When the client receive a 409 or 422 status code, it'll not retry that request, because this means that the request was
already made or there are invalid data being sent. To respond with the right error code, there's one strict validation
inside the Twit model, to raise a DuplicatedException when the twit already exists.



