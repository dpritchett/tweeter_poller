[![travis ci badge](https://api.travis-ci.org/dpritchett/tweeter_poller.png)](https://travis-ci.org/dpritchett/tweeter_poller)

# To run

0. start redis
1. Create a `.env` file like so: `cp .env.example .ev`
2. Create a Twitter app and get some API keys (https://dev.twitter.com/apps/new)
3. Add your keys to the `.env` file
4. `bundle install`
5. `ruby daemon.rb`
