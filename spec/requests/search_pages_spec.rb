require 'spec_helper'

describe "Search pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "feed show" do
    before do
        @credential = FactoryGirl.create(:credential, user: user) 
        @search = FactoryGirl.create(:search, user: user, credential: @credential, query: "foobar")
        visit root_path
    end
    it { should have_content('foobar') }
    it { should have_content('Started') }
    it { should have_content('Using') }
    it { should have_content(@search.credential_id) }
  end

  describe "search creation no credentials" do
    before { visit root_path }

    describe "with no credentials" do
      it { should have_content('Please add credential') }
    end

    describe "with invalid information" do
      it "should not create a search" do
        expect { click_button "Post" }.not_to change(Search, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

  end

  describe "search creation" do
    before do
      @credential = FactoryGirl.create(:credential, user: user)
      visit root_path
    end
    
    describe "with credentials" do
      it { should have_content(@credential.name) }
    end

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
      before do
        select @credential.name, from: 'search[credential_id]'
        fill_in 'search_query', with: "Lorem ipsum"
      end
      it "should create a search" do
        expect { click_button "Post" }.to change(Search, :count).by(1)
      end
    end
  end

  describe "search destruction" do
    before do
      @credential = FactoryGirl.create(:credential, user: user)
      @search = FactoryGirl.create(:search, user: user, credential: @credential)
    end
    describe "as correct user" do
      before { visit root_path }
      it "should delete a search" do
        expect { click_link "delete" }.to change(Search, :count).by(-1)
      end
    end
  end
end
