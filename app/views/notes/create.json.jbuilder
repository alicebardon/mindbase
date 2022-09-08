if @note.persisted?
  json.form render(partial: "shared/new_note", formats: :html, locals: {note: Note.new})
  json.inserted_item render(partial: "notes/note_card", formats: :html, locals: {note: @note})
else
  json.form render(partial: "shared/new_note", formats: :html, locals: {note: @note})
end
