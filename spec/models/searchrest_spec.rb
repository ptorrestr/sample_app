require 'spec_helper'

describe Searchrest do
  before do
    @searchrest = Searchrest.build()
    @searchrest.id = 1
    @searchrest.query = "query foo bar"
    @searchrest.consumer = "consumer foo bar"
    @searchrest.consumer_secret = "consumer secret foo bar"
    @searchrest.access = "access foo bar"
    @searchrest.access_secret = "access foo bar"
  end

  subject { @searchrest }

  it { should respond_to(:id) }
  it { should respond_to(:query) }
  it { should respond_to(:consumer) }
  it { should respond_to(:consumer_secret) }
  it { should respond_to(:access) }
  it { should respond_to(:access_secret) }
  
  it { should be_valid }

  describe "when query is not present" do
    before { @searchrest.query = " " }
    it { should_not be_valid }
  end

  describe "when consumer is not present" do
    before { @searchrest.consumer = " " }
    it { should_not be_valid }
  end

  describe "when consumer_secret is not present" do
    before { @searchrest.consumer_secret = " " }
    it { should_not be_valid }
  end

  describe "when access is not present" do
    before { @searchrest.access = " " }
    it { should_not be_valid }
  end

  describe "when access_secret is not present" do
    before { @searchrest.access_secret = " " }
    it { should_not be_valid }
  end

  describe "manipulate searchrest element" do
    before do
      @searchrest.save
    end

    it "confirm creation" do
      expect(Searchrest.exists?(@searchrest.id)).to eq true
    end

    it "find non-existing element" do
      expect(Searchrest.exists?(1000)).to eq false
    end

    describe "update element" do
      before do 
        @element = Searchrest.find(@searchrest.id)
        @oldquery = @element.query
        @element.query = "another query"
        @element.save
      end
      let(:updated_element) { Searchrest.find(@searchrest.id) }
      it "query could not be the old one" do
        expect(updated_element.query).to_not eq @oldquery
      end
    end

    after do
      @searchrest.destroy
      #expect(Searchrest.exists?(@searchrest.id)).to eq false }
    end
  end
end
