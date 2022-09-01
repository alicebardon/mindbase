class CategoriesController < ApplicationController
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = /^(.*)#\s*\$(.*)/

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
      @categories = current_user.categories
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
    parse_file(uploaded_file, params)
    redirect_to categories_path, notice: "File successfully uploaded"
  end

  private

  def parse_file(file, params)
    params[:note][:category_ids].delete("")
    programming_language = file.content_type.split("/")[1]
    matches = file.read.scan(JS_COMMENT)
    matches.each do |content_pair|
      note = Note.create!(code_content: content_pair[0],
                          content: content_pair[1],
                          user: current_user,
                          file_path: '/app/code.txt',
                          language: programming_language)
      params[:note][:category_ids].each do |cat_id|
        CategoryNote.create!(note: note, category_id: cat_id.to_i)
      end
    end
  end

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end

  def file_params
    params.require(:source_code)
  end
end
