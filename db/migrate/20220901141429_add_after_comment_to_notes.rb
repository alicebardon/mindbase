class AddAfterCommentToNotes < ActiveRecord::Migration[7.0]
  def up
    add_column :notes, :after_comment, :string
  end

  def down
    remove_column :notes, :after_comment
  end
end
