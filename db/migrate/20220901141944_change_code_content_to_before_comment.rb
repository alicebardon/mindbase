class ChangeCodeContentToBeforeComment < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :code_content, :before_comment
  end
end
