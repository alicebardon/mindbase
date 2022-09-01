class ChangeContentToComment < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :content, :comment
  end
end
