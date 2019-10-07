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
      @omniauth_facebook_hash = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '1234',
        info: {
          first_name: 'john',
          last_name: 'doe',
          email: 'test@example.com',
        }
      })

      @omniauth_name_hash = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '1234',
        info: {
          name: 'Cain Velasquez',
          email: 'cvalesquez@ufc.co'
        }
      })
    end

    it "retrieves an existing user" do
      user = User.create(
        first_name: 'jhon',
        last_name: 'doe',
        email: 'test@example.com',
        cellphone: '986587456',
        password: 'password',
        password_confirmation: 'password',
        address: 'koombea'
      )
      omniauth_user = User.from_omniauth(@omniauth_facebook_hash)

      expect(user).to eq(omniauth_user)
    end

    it "creates a new user if one doesn't already exist" do
      User.from_omniauth(@omniauth_facebook_hash)
      expect(User.count).to eq(1)
    end

    it "creates a new user with name parameter" do
      User.from_omniauth(@omniauth_name_hash)
      expect(User.count).to eq(1)
    end

    it "creates first_name parameter" do
      user = User.from_omniauth(@omniauth_name_hash)
      expect(user).to have_attributes(first_name: 'Cain')
    end

    it "creates last_name parameter" do
      user = User.from_omniauth(@omniauth_name_hash)
      expect(user).to have_attributes(last_name: 'Velasquez')
    end
  end
end
