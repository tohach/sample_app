require 'spec_helper'

describe Micropost do

  let(:user) {FactoryGirl.create(:user)}

  before do
    @micropost = user.microposts.build(content: "Text message")

  end


  subject {@micropost}

  it {should respond_to(:content) }
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) { should == user }

  it {should be_valid}

  describe "accessible attributes" do
    it "should not allow acces to user_id" do
      expect do
        User.new(user_id: "1")
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end


  describe "when user_id is not presenet" do
    before {@micropost.user_id = nil}
    it {should_not be_valid}
  end

  describe "with blank content" do
    before {@micropost.content = " "}
    it {should_not be_valid}
  end

  describe "with content that is too log" do
    before {@micropost.content = "a"*141}
    it {should_not be_valid}
  end
end
