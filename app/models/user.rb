class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 8..128
  has_many :products
  validates :first_name, presence: true
  validates :last_name, presence: true
  def name
    "#{first_name} #{last_name}"
  end
end
