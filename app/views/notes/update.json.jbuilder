if @note.persisted?
  json.note_html render(partial: "notes/note_card", formats: :html, locals: { note: @note })
end
