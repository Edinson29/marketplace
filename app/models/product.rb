class Product < ApplicationRecord
  enum status: %i[unpublished archived published]
  belongs_to :user
  has_many_attached :images
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
