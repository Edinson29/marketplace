require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
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

  it "has a unique email" do
    user = create(:user)
    user2 = build(:user, email: user.email)
    expect(user2).to_not be_valid
  end

  it { should have_many(:product) }
end
