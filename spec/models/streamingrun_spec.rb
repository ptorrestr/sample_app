require 'spec_helper'

describe Streamingrun do
  before do
    @streamingrest = Streamingrest.build()
    @streamingrest.id = 1
    @streamingrest.query = "query foo bar"
    @streamingrest.consumer = "consumer foo bar"
    @streamingrest.consumer_secret = "consumer secret foo bar"
    @streamingrest.access = "access foo bar"
    @streamingrest.access_secret = "access foo bar"
    @streamingrest.save

    @streamingrun = Streamingrun.build()
    @streamingrun.streaming = @streamingrest.id
  end

  subject { @streamingrun }

  it { should respond_to(:id) }
  it { should respond_to(:streaming) }

  it { should be_valid }

  describe "when streaming is not present" do
    before { @streamingrun.streaming = " " }
    it { should_not be_valid }
  end

  describe "manipulate streamingrun element" do
    before do
      @streamingrun.save
    end

    it "confirm creation" do
      expect(Streamingrun.exists?(@streamingrun.id)).to eq true
    end

    it "find non-existing element" do
      expect(Streamingrun.exists?(1000)).to eq false
    end

    after do
      @streamingrun.destroy
    end
  end

  after do
    @streamingrest.destroy
  end
end
