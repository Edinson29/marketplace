class ProductsController < ApplicationController
  def index
    @products = Product.published
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save ? redirect_to(@product) : render('new')
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :user_id)
  end
end
