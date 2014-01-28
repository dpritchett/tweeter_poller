require_relative '../../spec_helper'

describe TweetStream::Poller do
  let(:klass) { TweetStream::Poller }
  subject { klass.new }

  it "should respond_to search" do
    subject.respond_to?(:search).must_equal true
  end
end
