require 'spec_helper'

describe Search do
  let(:user) { FactoryGirl.create(:user)}
  let(:credential) { FactoryGirl.create(:credential, user: user) }
  before do
    @search = user.searches.build(query: "Lorem ipsum", credential: credential)
  end

  subject { @search }

  it { should respond_to(:query) }
  it { should respond_to(:user_id) }
  it { should respond_to(:credential_id) }
  it { should respond_to(:user) }
  it { should respond_to(:credential) }
  it { should respond_to(:tweets) }
  it { should respond_to(:all_tweets) }
  it { should respond_to(:all_tweets_csv) }
  its(:user) { should eq user }
  its(:credential) { should eq credential }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @search.user_id = nil }
    it { should_not be_valid }
  end

  describe "when credential_id is not present" do
    before { @search.credential_id = nil }
    it { should_not be_valid }
  end

  describe "with blank query" do
    before { @search.query = " " }
    it { should_not be_valid }
  end

  describe "with query that is too long" do
    before { @search.query = "a" * 141 }
    it { should_not be_valid}
  end

end
