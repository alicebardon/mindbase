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

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
