require 'spec_helper'

describe Streamingrest do
  before do
    @streamingrest = Streamingrest.build()
    @streamingrest.id = 1
    @streamingrest.query = "query foo bar"
    @streamingrest.consumer = "consumer foo bar"
    @streamingrest.consumer_secret = "consumer secret foo bar"
    @streamingrest.access = "access foo bar"
    @streamingrest.access_secret = "access foo bar"
  end

  subject { @streamingrest }

  it { should respond_to(:id) }
  it { should respond_to(:query) }
  it { should respond_to(:consumer) }
  it { should respond_to(:consumer_secret) }
  it { should respond_to(:access) }
  it { should respond_to(:access_secret) }
  
  it { should be_valid }

  describe "when query is not present" do
    before { @streamingrest.query = " " }
    it { should_not be_valid }
  end

  describe "when consumer is not present" do
    before { @streamingrest.consumer = " " }
    it { should_not be_valid }
  end

  describe "when consumer_secret is not present" do
    before { @streamingrest.consumer_secret = " " }
    it { should_not be_valid }
  end

  describe "when access is not present" do
    before { @streamingrest.access = " " }
    it { should_not be_valid }
  end

  describe "when access_secret is not present" do
    before { @streamingrest.access_secret = " " }
    it { should_not be_valid }
  end

  describe "manipulate streamingrest element" do
    before do
      @streamingrest.save
    end

    it "confirm creation" do
      expect(Streamingrest.exists?(@streamingrest.id)).to eq true
    end

    it "find non-existing element" do
      expect(Streamingrest.exists?(1000)).to eq false
    end

    describe "update element" do
      before do 
        @element = Streamingrest.find(@streamingrest.id)
        @oldquery = @element.query
        @element.query = "another query"
        @element.save
      end
      let(:updated_element) { Streamingrest.find(@streamingrest.id) }
      it "query could not be the old one" do
        expect(updated_element.query).to_not eq @oldquery
      end
    end

    after do
      @streamingrest.destroy
    end
  end
end
