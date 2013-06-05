require 'spec_helper'

describe Search do
  let(:user) { FactoryGirl.create(:user)}
  before { @search = user.searches.build(query: "Lorem ipsum") }

  subject { @search }

  it { should respond_to(:query) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @search.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank query" do
    before { @search.query = " " }
    it { should_not be_valid }
  end

  describe "with query that is too long" do
    before { @search.query = "a" * 141 }
    it { should_not be_valid}
  end
end
