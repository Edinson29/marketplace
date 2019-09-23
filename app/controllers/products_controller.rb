class ProductsController < ApplicationController
  before_action :set_product, except: %i[index new create my_products]
  before_action :authenticate_user!, except: %i[index show]
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

  def archived
    @product.archived!
    redirect_to my_products_path
  end

  def my_products
    @my_products = current_user.products
  end

  def publish
    @product.published!
    redirect_to my_products_path
  end

  def unpublish
    @product.unpublished!
    redirect_to my_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :user_id, :category_id, images_attributes: [ :id, :avatar, :_destroy])
  end
end
