class Note < ApplicationRecord
  belongs_to :user
  has_many :category_notes
  has_many :categories, through: :category_notes

  validates :content, presence: true
  validates :user_id, presence: true

  def all_categories_names
    categories.pluck(:name)
  end
end
