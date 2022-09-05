class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :content
      t.string :file_name
      t.string :language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
