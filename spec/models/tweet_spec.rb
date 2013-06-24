require 'spec_helper'

describe Tweet do
  before do
    @tweet = Tweet.build()
    @tweet.id = 1
    @tweet.created_at = "date text"
    @tweet.text = "twitter text foo bar"
  end

  subject { @tweet }

  it { should respond_to(:id) }
  it { should respond_to(:created_at) } 
  it { should respond_to(:favorited) }
  it { should respond_to(:text) }
  it { should respond_to(:in_reply_to_screen_name) }
  it { should respond_to(:in_reply_to_user_id) }
  it { should respond_to(:in_reply_to_status_id) }
  it { should respond_to(:truncated) }
  it { should respond_to(:source) }
  it { should respond_to(:urls) }
  it { should respond_to(:user_mentions) }
  it { should respond_to(:hashtags) }
  it { should respond_to(:geo) }
  it { should respond_to(:place) }
  it { should respond_to(:coordinates) }
  it { should respond_to(:contributors) }
  it { should respond_to(:retweeted) }
  it { should respond_to(:retweet_count) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user_name) } 
  
  it { should be_valid }


  describe "when text is not present" do
    before { @tweet.text = "" }
    it { should_not be_valid }
  end

  describe "when created_at is not present" do
    before { @tweet.created_at = "" }
    it { should_not be_valid }
  end

  describe "manipulate tweet" do
    before do
      @tweet.text = "other twitter text foo bar"
      @tweet.save
    end

    it "confirm creation" do
      expect(Tweet.exists?(@tweet.id)).to eq true
    end

    it "find non-existing element" do
      expect(Tweet.exists?(1000)).to eq false
    end

    describe "update element" do
      before do 
        @oldtext = @tweet.text
        @tweet.text = "another text"
        @tweet.save
      end
      let(:updated_element) { Tweet.find(@tweet.id) }
      it "query could not be the old one" do
        expect(updated_element.text).to_not eq @oldtext
      end

      it "query should be the new" do
        expect(updated_element.text).to eq @tweet.text
      end
    end

    after do
      @tweet.destroy
    end
  end
end
