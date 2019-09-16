require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
    expect(create(:category, name: 'primary')).to be_valid
  end

  it { should validate_presence_of(:name) }
end
