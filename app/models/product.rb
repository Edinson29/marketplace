class Product < ApplicationRecord
  enum status: %i[unpublished archived published]
  belongs_to :user
  belongs_to :category
  has_many :images, inverse_of: :product, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  accepts_nested_attributes_for :images, allow_destroy: true
  after_save :send_email, if: :change_to_published

  private

  def change_to_published
    saved_change_to_attribute?('status', to: 'published')
  end

  def send_email
    User.find_each do |user|
      ProductMailer.published_product(user, self).deliver_now
    end
  end
end
