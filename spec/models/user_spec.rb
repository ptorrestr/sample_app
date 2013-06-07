require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:searches) }
  it { should respond_to(:credentials) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "when password confirmation is nil" do
    before do
      @user = User.new(name: "Michael Hartl", email: "mhartl@example.com",
                       password: "foobar", password_confirmation: nil)
    end
    it { should_not be_valid }
  end
  describe "when password confirmation is nil" do
    before do
      @user = User.new(name: "Michael Hartl", email: "mhartl@example.com",
                       password: "foobar", password_confirmation: nil)
    end
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  #Search.. from here manually
  describe "search associations" do
    before { @user.save }
    let!(:older_search) do
      @credential = FactoryGirl.create(:credential, user: @user, name: "older")
      FactoryGirl.create(:search, user: @user, created_at: 1.day.ago, credential: @credential)
    end
    let!(:newer_search) do
      @credential = FactoryGirl.create(:credential, user: @user, name: "newer")
      FactoryGirl.create(:search, user: @user, created_at: 1.hour.ago, credential: @credential)
    end
    
    it "should have the right searches in the right order" do
      expect(@user.searches.to_a).to eq [newer_search, older_search]
    end

    it "should destroy associated seaches" do
      searches = @user.searches.to_a
      @user.destroy
      expect(searches).not_to be_empty
      searches.each do |search|
        expect(Search.where(id: search.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        @credential = FactoryGirl.create(:credential, user: @user)
        FactoryGirl.create(:search, user: FactoryGirl.create(:user), credential: @credential)
      end
      its(:feed) { should include(newer_search) }
      its(:feed) { should include(older_search) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end

  #Credentials
  describe "credentials associations" do
    before { @user.save }
    let!(:older_credential) do
      FactoryGirl.create(:credential, user: @user, created_at: 1.day.ago, name: "older")
    end
    let!(:newer_credential) do
      FactoryGirl.create(:credential, user: @user, created_at: 1.hour.ago, name: "newer")
    end

    it "should have the right credentials in the right order" do
      expect(@user.credentials.to_a).to eq [newer_credential, older_credential]
    end

    it "should detroy associated credentials" do
      credentials = @user.credentials.to_a
      @user.destroy
      expect(credentials).not_to be_empty
      credentials.each do |credential|
        expect(Credential.where(id: credential.id)).to be_empty
      end
    end
  end
end
