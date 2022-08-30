class NotesController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    # create a note_category
    if @note.save
      category_ids = params[:note][:category_ids].delete("")
      category_ids.each { |cat| NoteCategory.create(note: @note, category: cat) }
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = Note.find(params[:note_id])
    @note.update(note_params)
  end

  def update

  end

  def destroy
  end

  private

  def set_restaurant
    @category = Category.find(params[:category_id])
  end

  def note_params
    params.require(:note).permit(:content, :code_content, :language, :file_path)
  end

end
