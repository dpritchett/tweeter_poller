module TweetStream
  require 'pry'
  require 'redis'
  require 'twitter'

  require 'dotenv'
  Dotenv.load

  require_relative "tweet_stream/listener"
end
