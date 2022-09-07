class NotesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    respond_to do |format|
      if @note.save
        CategoryNote.create(note: @note, category_id: params[:note][:category_id])
        # format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render :new, status: :unprocessable_entity }
      end
      format.json # Follow the classic Rails flow and look for a create.json view
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

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def note_params
    params.require(:note).permit(:code, :comment, :language, :file_name)
  end

  def note_params_edit
    params.require(:note).permit(:code, :comment)
  end
end
