require 'spec_helper'

describe Tweetsearch do
  before do
    @tweetsearch = Tweetsearch.build()
  end

  subject { @tweetsearch }

  it { should respond_to(:id) }
  it { should respond_to(:tweet_id) }
  it { should respond_to(:search_id) }
  
  it { should be_valid }

  describe "manipulate tweetsarch element" do
    before do
      @searchrest = Searchrest.build()
      @searchrest.id = 1
      @searchrest.query = "query foo"
      @searchrest.consumer = "consumer foo"
      @searchrest.consumer_secret = "consumer secret foo"
      @searchrest.access = "access foo"
      @searchrest.access_secret = "access secret foo"
      @searchrest.save

      @tweet = Tweet.build()
      @tweet.id = 1
      @tweet.save

      @tweetsearch.tweet_id = @tweet.id
      @tweetsearch.search_id = @searchrest.id
      @tweetsearch.save
    end

    it "confirm creation" do
      expect(Tweetsearch.exists?(@tweetsearch.id)).to eq true
    end

    it "find non-existing element" do
      expect(Tweetsearch.exists?(1000)).to eq false
    end

    after do
      @searchrest.destroy
      @tweet.destroy
      #automatically destroyed when searchrest and tweet are destroyed
      #@tweetsearch.destroy
    end
  end
end
