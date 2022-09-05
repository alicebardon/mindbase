class RemoveBeforeAndAfterCommentFromNotes < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :before_comment, :code
    remove_column :notes, :after_comment
  end
end
