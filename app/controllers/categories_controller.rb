class CategoriesController < ApplicationController
  def index
    @categories = Category.where(user: current_user)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    @category.user =current_user
    if @category.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end
end
