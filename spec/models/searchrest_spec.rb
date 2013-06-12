require 'spec_helper'

describe Searchrest do
  before do
    @searchrest = Searchrest.build()
  end

  subject { @searchrest }

  it { should respond_to(:query) }
  it { should respond_to(:consumer) }
  it { should respond_to(:consumer_secret) }
  it { should respond_to(:access) }
  it { should respond_to(:access_secret) }
  it { should respond_to(:search_id) }
  
  it { should be_valid }

  describe "manipulate searchrest element" do
    before do
      @max = 0
      @collection = Searchrest.find(:all)
      @collection.each do |elem|
        if elem.search_id > @max
          @max = elem.search_id
        end
      end
      @searchrest.query = "query foo"
      @searchrest.consumer = "consumer foo"
      @searchrest.consumer_secret = "consumer secret foo"
      @searchrest.access = "access foo"
      @searchrest.access_secret = "access secret foo"
      @searchrest.search_id = (@max+1)
      @searchrest.save
    end

    it "confirm creation" do
      expect(Searchrest.exists?(@searchrest.id)).to eq true
    end

    it "find non-existing element" do
      expect(Searchrest.exists?(1000)).to eq false
    end

    describe "find existing element" do
      before { @element = Searchrest.find(@searchrest.id) }
      it { should eq @element }
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

    describe "delete element" do
      before do
        @id = @searchrest.id
        Searchrest.find(@id).destroy
      end
      it { expect(Searchrest.exists?(@id)).to eq false }
    end
  end
end
