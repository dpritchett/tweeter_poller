require 'logger'
require 'shellwords'

ONE_DAY          = 60 * 60 * 24
ONE_WEEK         = ONE_DAY * 7
MAX_RESULTS      = 10
SECONDS_DELAY    = 30

module TweetStream
  class Poller
    def initialize(key="memphis ruby")
      @key = key.to_s.strip.downcase
      self
    end

    attr_reader :key

    def main
      logger.info "Booting..."

      loop do
        search

        sleep 1
        notify read_all

        sleep SECONDS_DELAY
      end
    end

    def search
      results = searcher.search_results(key, age_limit: ONE_WEEK)

      if results.any?
        logger.info "#{Time.now}: Storing #{results.count} results for query < #{key} >."
        redis.lpush(key, results)
      else
        logger.info "#{Time.now}: No new results found."
      end
    end

    def notify(*tweets)
      tweets = [tweets].flatten

      unless (n = tweets.count).zero?
        logger.info "#{Time.now}: Notifying #{n} tweet(s)."
      end

      tweets.each do |tweet|
        escaped = Shellwords.shellescape(tweet)

        system "script/notify", escaped
      end
    end

    def read_all
      results = []

      while (tweet = redis.lpop(key)) && results.count < MAX_RESULTS
        results << tweet
      end

      results
    end

    def redis
      @redis_memo || Redis.new
    end

    def searcher
      @searcher_memo ||= TweetStream::Searcher.new
    end

    def logger(destination=STDOUT)
      @logger_memo ||= Logger.new(destination)
    end
  end
end
