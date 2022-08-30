class CategoriesController < ApplicationController
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = /^(.*)#\s*\$(.*)/

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

  def upload_file
    uploaded_file = params[:source_code]
    File.open(Rails.root.join('public', 'uploads',
                              uploaded_file.original_filename),
                              'wb') do |file|
      file.write(uploaded_file.read)
    end
    parse_source_code(uploaded_file.read)
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

    @js_code = "// This is a javascript comment
            for (let i = 0; i < 10; i++) { // $ This is a javascript comment for Mindbase
            console.log(array[i]); // $ I would like to upload this to Mindbase
            } // This is a comment I don't want to upload to Mindbase"
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
    @notes = Note.all
    @comment_char = "//"
  end

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end
end
