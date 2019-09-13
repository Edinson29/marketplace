class Product < ApplicationRecord
  enum status: %i[unpublished archived published]
  belongs_to :user
  has_many :images, inverse_of: :product, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  accepts_nested_attributes_for :images, allow_destroy: true
end
