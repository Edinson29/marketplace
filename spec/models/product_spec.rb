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

  it { should callback(:send_email).after(:save).if(:change_to_published) }

  describe "send email" do
    before do
      @user = create(:user)
      @category = create(:category)
    end

    it "sends email to the users" do
      expect {
        create(:product, status: 'published', user_id: @user.id, category_id: @category.id)
      }.to change(ActionMailer::Base.deliveries, :count).by(User.all.length)
    end

    it "is not send email to users" do
      expect {
        create(:product, status: 'unpublished', user_id: @user.id, category_id: @category.id)
      }.to change(ActionMailer::Base.deliveries, :count).by(0)
    end
  end
end
