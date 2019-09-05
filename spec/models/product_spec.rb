require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    expect(build(:product, user_id: user.id)).to be_valid
  end

  context "validate the presence of the parameters" do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:quantity) }

    it { should validate_presence_of(:price) }
  end

  it { should belong_to(:user) }
end
