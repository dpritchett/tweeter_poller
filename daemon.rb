require 'pry'
require 'date'
require './lib/tweet_stream'

MAX_RESULTS = 10
SECONDS_DELAY       = 30

def main
  key      = "memphis ruby"

  loop do
    search key

    sleep 1
    puts read_all(key).join("\n\n")

    sleep SECONDS_DELAY
  end
end

def search(key)
  results = listener.search_results(key)

  if results.any?
    redis.lpush(key, results)
  else
    puts "#{Time.now}: No new results found..."
  end
end

def read_all(key)
  results = []

  while (tweet = redis.lpop(key)) && results.count < MAX_RESULTS
    results << tweet
  end

  results
end

def redis
  @redis_memo || Redis.new
end

def listener
  @listener_memo ||= TweetStream::Listener.new
end

main
