class CategoryNote < ApplicationRecord
  belongs_to :note
  belongs_to :category

  validates :note_id, presence: true
  validates :category_id, presence: true
end
