class CategoriesController < ApplicationController
  before_action :set_category, except: %i[index new create]
  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    @category.save ? redirect_to(@category) : render('new')
  end

  def update
    @category.update(category_params) ? redirect_to(@category) : render('edit')
  end

  def destroy
    @category.delete
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
