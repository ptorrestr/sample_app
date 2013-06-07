require 'spec_helper'

describe Credential do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @credential = user.credentials.build(consumer: "foobar",
                                consumer_secret: "foobar", access: "foobar",
                                access_secret: "foobar", name: "foobar") }
  
  subject { @credential }
  it { should respond_to(:consumer) }
  it { should respond_to(:consumer_secret) }
  it { should respond_to(:access) }
  it { should respond_to(:access_secret) }
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }

  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @credential.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank consumer" do
    before { @credential.consumer = " " }
    it { should_not be_valid }
  end

  describe "with blank consumer_secret" do
    before { @credential.consumer_secret = " " }
    it { should_not be_valid }
  end

  describe "with blank access" do
    before { @credential.access = " " }
    it { should_not be_valid }
  end

  describe "with blank access_secret" do
    before { @credential.access_secret = " " }
    it { should_not be_valid }
  end
end
