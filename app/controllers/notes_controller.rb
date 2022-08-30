class NotesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

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
end
