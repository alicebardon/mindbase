class AddCodeContentToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :code_content, :string
  end
end
