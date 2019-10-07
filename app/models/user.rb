class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]
  has_many :products
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    data = auth.info
    email = data.email
    user = User.where(email: email).first

    if !user && !email.blank?
      password = Devise.friendly_token[8, 20]
      name = data.name
      first_name = data.first_name || name.split(' ').first
      last_name = data.last_name || name.split(' ').last
      user = User.create(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        password_confirmation: password
      )
    end
    user
  end
end
