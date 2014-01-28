module TweetStream
  require 'pry'
  require 'redis'
  require 'twitter'

  require 'dotenv'
  Dotenv.load

  require_relative "./tweet_stream/searcher"
  require_relative "./tweet_stream/poller"
end
