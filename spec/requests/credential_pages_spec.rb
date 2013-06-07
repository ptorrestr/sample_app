require 'spec_helper'

describe "Credential pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "credential creation" do
    before { visit credentials_path }
    
    describe "with invalid information" do
      it "should not create a credential" do
        expect { click_button "Add" }.not_to change(Credential, :count)
      end
      describe "error messages" do
        before { click_button "Add" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'credential_name', with: "foobarname"
        fill_in 'credential_consumer', with: "foobarconsumer"
        fill_in 'credential_consumer_secret', with: "foobarconsumersecret"
        fill_in 'credential_access', with: "foobaraccess"
        fill_in 'credential_access_secret', with: "foobaraccesssecret"
      end
      it "should create a micropost" do
        expect { click_button "Add" }.to change(Credential, :count).by(1)
      end
    end
  end

  describe "credential destruction" do
    before do
      @credential = FactoryGirl.create(:credential, user: user)
      visit credentials_path
    end
    
    it "should show delete link" do
      should have_link('delete', href: credential_path(@credential))
    end
    
    it "should be able to delete credential" do
       expect { click_link('delete') }.to change(Credential, :count).by(-1)
    end
  end
end
