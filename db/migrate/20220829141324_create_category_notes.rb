class CreateCategoryNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :category_notes do |t|
      t.references :note, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
