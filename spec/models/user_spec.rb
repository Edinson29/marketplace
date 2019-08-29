require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:all) do
    @user1 = create(:user)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    user2 = build(:user, email: "blah@gmail.com")
    expect(user2).to_not be_valid
  end

  it "is not valid whitout a first_name" do
    user2 = build(:user, first_name: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without a last_name" do
    user2 = build(:user, last_name: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without a email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end
end
