About HTTP POST Parrot
=================================

HTTP Post Parrot is a little [Sinatra](http://sinatrarb.com) web application
that remembers data
[POST](http://en.wikipedia.org/wiki/POST_(HTTP))ed to a 'listen' route:

    $ curl http://vivid-earth-821.heroku.com/listen/foo -d "bar" 

Remembered data can be retrieved by [GET](http://en.wikipedia.org/wiki/POST_(HTTP))tting the associated 'repeat' route:

    $ curl http://vivid-earth-821.heroku.com/repeat/foo 
    $ bar

An [instance](http://vivid-earth-821.heroku.com) of the app (currently the master branch) runs on
[Heroku](http://heroku.com). Feel free to give it a try.  

To run your own version locally, do this:
    $ git clone http://github.com/jamesmartin/http_post_parrot
    $ bundle install
    $ rake start

You'll need the key/value datastore, [redis](http://redis.io/). HTTP Post
Parrot uses Redis to persist the data you post. To
install redis on a homebrew enabled OSX, try:

  $ brew install redis
