require 'spec_helper'

describe Twitteruser do
  before do
    @twitteruser = Twitteruser.build()
    @twitteruser.id = 1
    @twitteruser.created_at = "date text"
    @twitteruser.name = "user name"
  end

  subject { @twitteruser }

  it { should respond_to(:id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:name) }
  it { should respond_to(:screen_name) }
  it { should respond_to(:location) }
  it { should respond_to(:description) }
  it { should respond_to(:profile_image_url) }
  it { should respond_to(:profile_image_url_https) }
  it { should respond_to(:profile_background_tile) }
  it { should respond_to(:profile_background_image_url) }
  it { should respond_to(:profile_background_color) }
  it { should respond_to(:profile_sidebar_fill_color) }
  it { should respond_to(:profile_sidebar_border_color) }
  it { should respond_to(:profile_link_color) }
  it { should respond_to(:profile_text_color) }
  it { should respond_to(:protected) }
  it { should respond_to(:utc_offset) }
  it { should respond_to(:time_zone) }
  it { should respond_to(:followers_count) }
  it { should respond_to(:friends_count) }
  it { should respond_to(:statuses_count) }
  it { should respond_to(:favourites_count) }
  it { should respond_to(:url) }
  it { should respond_to(:geo_enabled) }
  it { should respond_to(:verified) }
  it { should respond_to(:lang) }
  it { should respond_to(:notifications) }
  it { should respond_to(:contributors_enabled) }
  it { should respond_to(:listed_count) }
  it { should respond_to(:linenos) } 
  it { should respond_to(:language) } 
  it { should respond_to(:style) }
  
  it { should be_valid }

  describe "when name is not present" do
    before { @twitteruser.name = "" }
    it { should_not be_valid }
  end

  describe "when created_at is not present" do
    before { @twitteruser.created_at = "" }
    it { should_not be_valid }
  end

  describe "manipulate tweet" do
    before do
      @twitteruser.save
    end

    it "confirm creation" do
      expect(Twitteruser.exists?(@twitteruser.id)).to eq true
    end

    it "find non-existing element" do
      expect(Twitteruser.exists?(1000)).to eq false
    end

    describe "update element" do
      before do 
        @oldname = @twitteruser.name
        @twitteruser.name = "another user name"
        @twitteruser.save
      end
      let(:updated_element) { Twitteruser.find(@twitteruser.id) }
      it "query could not be the old one" do
        expect(updated_element.name).to_not eq @oldname
      end

      it "query should be the new" do
        expect(updated_element.name).to eq @twitteruser.name
      end
    end

    after do
      @twitteruser.destroy
    end
  end
end
