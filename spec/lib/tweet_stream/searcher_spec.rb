require_relative '../../spec_helper'

describe TweetStream::Searcher do
  subject { TweetStream::Searcher.new }
  describe "search results" do
    let(:query_string)     { 'ruby' }

    describe "age limit = 7 days" do
      let(:age_limit) { 60 * 60 * 24 * 7 }
      let(:results)   { subject.search_results(query_string, age_limit: age_limit) }

      it "should return results" do
        results.any?.must_equal true
      end


      it "results should include the query string" do
        keepers = results.select { |r| r.downcase.include?(query_string)}
        keepers.any?.must_equal true
      end
    end
  end
end
