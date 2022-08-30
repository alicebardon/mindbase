class NotesController < ApplicationController
<<<<<<< HEAD
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = /^(.*)#\s*\$(.*)/

=======
  before_action :set_category, only: [:show, :edit, :update, :destroy]
>>>>>>> master

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      params[:note][:category_ids].delete("")
      params[:note][:category_ids].each { |cat| CategoryNote.create(note: @note, category_id: cat.to_i) }
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
  @note = Note.find(params[:id])
  if @note.update(note_params_edit)
    redirect_to category_path(@category)
  else
    render :edit, status: :unprocessable_entity
  end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to category_path(@category)
  end

<<<<<<< HEAD
  def parse_source_code
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
    matches = @js_code.scan(JS_COMMENT)
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
=======
  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def note_params
    params.require(:note).permit(:content, :code_content, :language, :file_path)
  end

  def note_params_edit
    params.require(:note).permit(:content, :code_content)
  end

>>>>>>> master
end
