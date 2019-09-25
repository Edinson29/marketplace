require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    expect(build(:product)).to be_valid
  end

  context "validate the presence of the parameters" do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:quantity) }

    it { should validate_presence_of(:price) }
  end

  it { should belong_to(:user) }

  it { should belong_to(:category) }

  it { should have_many(:images) }

  it { should accept_nested_attributes_for(:images).allow_destroy(true) }

  context "validate the product state" do
    it "validates unpublished status by default" do
      expect(build(:product)).to have_attributes(status: 'unpublished')
    end
  end

  it { should callback(:send_email).after(:update).if(:change_to_published) }

  describe "methods" do
    it "sends email to all users" do
      expect { subject.send(:send_email) }.to change(ActionMailer::Base.deliveries, :count).by(User.all.length)
    end

    it "returns a real value" do
      expect(subject.send(:change_to_published)).to be_truthy
    end
  end
end
