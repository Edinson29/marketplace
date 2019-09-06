class ProductsController < ApplicationController
  def index
    @products = Product.order("id ASC")
  end
end
