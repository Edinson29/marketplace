class Product < ApplicationRecord
  enum status: %i[unpublished archived published]
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
