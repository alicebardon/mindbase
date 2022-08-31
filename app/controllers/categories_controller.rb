class CategoriesController < ApplicationController
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = /^(.*)#\s*\$(.*)/

    def index
      if params[:query].present?
        @categories = Category.where("name ILIKE ?", "%#{params[:query]}%")
      else
        @categories = Category.all
      end
    end

  # def index
  #   @categories = Category.where(user: current_user)
  # end

  def show
    @category = Category.find(params[:id])
    @notes = Note.all
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
    uploaded_file = params[:source_code]
    parse_source_code(uploaded_file.read)
    user = User.last
    random_category = Category.last.nil? ? Category.create(name: "javascript", user: user, category_type: "language") : Category.last
    redirect_to category_path(random_category)
  end

  private

  def parse_source_code(text)
    @sample_text = "// This is a javascript comment
                for (let i = 0; i < 10; i++) { // $ This is a javascript comment for Mindbase
                  console.log(array[i]); // $ I would like to upload this to Mindbase
                # This is a ruby comment
                array.each do |elem| # $ This is a ruby comment for Mindbase
                # This is a python comment
                <!-- This is an HTML comment -->
                /* This is a CSS comment */"
    Note.destroy_all
    user = User.first
    matches = text.scan(JS_COMMENT)
    matches.each do |match_pair|
      Note.create!(code_content: match_pair[0],
                   content: match_pair[1],
                   user: user,
                   file_path: '/app/code.txt',
                   language: 'javascript')
    end
  end

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end
end
