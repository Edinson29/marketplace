require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
    expect(build(:category)).to be_valid
  end

  it { should validate_presence_of(:name) }
end
