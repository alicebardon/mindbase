class CategoriesController < ApplicationController
  before_action :load_repos
  include ActionView::Helpers::DateHelper

  def index
    if params[:query].present?
      sql_query = <<~SQL
        categories.name @@ :query
        OR notes.code @@ :query
        OR notes.comment @@ :query
      SQL
      @categories = Category.joins(:notes)
                            .where(sql_query, query: "%#{params[:query]}%")
                            .distinct
    else
      @categories = current_user.categories
    end
    # @datetime = Time.now.utc - cat.updated_at
    #   <% if ((Time.now.utc - cat.updated_at) / 3600) < 24 %>
    #                           <%= "Today" %>
    #                           <% else %>
    #                           <%= cat.updated_at.strftime("%m/%d/%Y") %>
    #                           <% end
  end


  def show
    @category = Category.find(params[:id])
    if params[:query].present?
      sql_query = "code ILIKE :query OR comment ILIKE :query"
      @notes = @category.notes.where(sql_query, query: "%#{params[:query]}%").sort_by(&:created_at)
    else
      @notes = @category.notes.sort_by(&:created_at)
    end
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    @category.user = current_user
    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(cat_params)
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path, status: :see_other
  end

  def upload_file
    uploaded_file = file_params
    SourceCodeParser.parse_file(uploaded_file, params, current_user)
    redirect_to categories_path, notice: "File successfully uploaded"
  end

  private

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end

  def file_params
    params.require(:source_code)
  end

  def load_repos
    @client = Octokit::Client.new(access_token: current_user.access_token)
    @limit = @client.rate_limit_remaining
  end
end
