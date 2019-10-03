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

  it { should have_many(:products) }
  describe "#from_omniauth" do
    before do
      @omniauth_google_hash = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '1234',
        info: {
          first_name: 'john',
          last_name: 'doe',
          email: 'test@example.com',
          password: 'password'
        }
      })
    end

    it "retrieves an existing user" do
      user = User.new(
        first_name: 'jhon',
        last_name: 'doe',
        email: 'test@example.com',
        cellphone: '986587456',
        password: 'password',
        password_confirmation: 'password',
        address: 'koombea'
      )
      user.save
      omniauth_user = User.from_omniauth(@omniauth_google_hash)

      expect(user).to eq(omniauth_user)
    end

    it "creates a new user if one doesn't already exist" do
      User.from_omniauth(@omniauth_google_hash)
      expect(User.count).to eq(1)
    end
  end
end
