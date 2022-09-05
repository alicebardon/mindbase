class RenameNotesFilePathToFileName < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :file_path, :file_name
  end
end
