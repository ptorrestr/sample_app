require 'spec_helper'

describe "Search pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "search creation" do
    before { visit root_path }
    describe "with invalid information" do
      it "should not create a search" do
        expect { click_button "Post" }.not_to change(Search, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before { fill_in 'search_query', with: "Lorem ipsum" }
      it "should create a search" do
        expect { click_button "Post" }.to change(Search, :count).by(1)
      end
    end
  end

  describe "search destruction" do
    before { FactoryGirl.create(:search, user:user) }
    describe "as correct user" do
      before { visit root_path }
      it "should delete a search" do
        expect { click_link "delete" }.to change(Search, :count).by(-1)
      end
    end
  end
end
