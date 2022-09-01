class CategoriesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        categories.name ILIKE :query
        OR notes.content ILIKE :query
        OR notes.code_content ILIKE :query
      SQL
      @categories = Category.joins(:notes)
                            .where(sql_query, query: "%#{params[:query]}%")
                            .distinct
    else
      @categories = Category.all
    end
  end

  def show
    @category = Category.find(params[:id])

    if params[:query].present?
      sql_query = "content ILIKE :query OR code_content ILIKE :query"
      @notes = @category.notes.where(sql_query, query: "%#{params[:query]}%")
    else
      @notes = @category.notes
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
      redirect_to new_note_path
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
end
