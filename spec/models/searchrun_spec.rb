require 'spec_helper'

describe Searchrun do
  before do
    @searchrest = Searchrest.build()
    @searchrest.id = 1
    @searchrest.query = "query foo bar"
    @searchrest.consumer = "consumer foo bar"
    @searchrest.consumer_secret = "consumer secret foo bar"
    @searchrest.access = "access foo bar"
    @searchrest.access_secret = "access foo bar"
    @searchrest.save

    @searchrun = Searchrun.build()
    @searchrun.search = @searchrest.id
  end

  subject { @searchrun }

  it { should respond_to(:id) }
  it { should respond_to(:search) }

  it { should be_valid }

  describe "when search is not present" do
    before { @searchrun.search = " " }
    it { should_not be_valid }
  end

  describe "manipulate searchrun element" do
    before do
      @searchrun.save
    end

    it "confirm creation" do
      expect(Searchrun.exists?(@searchrun.id)).to eq true
    end

    it "find non-existing element" do
      expect(Searchrun.exists?(1000)).to eq false
    end

    after do
      @searchrun.destroy
    end
  end

  after do
    @searchrest.destroy
  end
end
