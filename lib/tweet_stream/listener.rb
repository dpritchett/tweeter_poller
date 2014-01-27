module TweetStream
  class Listener
    def initialize
      self
    end

    def search_results(querystring, age_limit=30)
      res    = client.search(querystring)
      tweets = res.reject { |t| (Time.now - t.created_at) > age_limit }
      format_tweets tweets
    end

    private
    def format_tweets(tweets)
      tweets.map{ |t| "#{t.full_text}\n\n\t- @#{t.user.handle} // #{t.created_at}" }
    end

    def client
      @client_memo ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
        config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
        config.access_token        = ENV.fetch("TWITTER_CONSUMER_ACCESS_TOKEN")
        config.access_token_secret = ENV.fetch("TWITTER_CONSUMER_ACCESS_SECRET")
      end
    end
  end
end
