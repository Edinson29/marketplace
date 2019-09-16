class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  def index
    @products = Product.published
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    @product.save ? redirect_to(@product) : render('new')
  end

  def show; end

  def update
    @product.update(product_params) ? redirect_to(@product) : render('edit')
  end

  def destroy
    @product.delete
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :user_id, :category_id, images_attributes: [ :id, :avatar, :_destroy])
  end
end
