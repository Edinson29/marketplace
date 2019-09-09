class User < ApplicationRecord
  has_many :products
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  def name
    "#{first_name} #{last_name}"
  end
end
