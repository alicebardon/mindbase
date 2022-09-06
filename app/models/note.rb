class Note < ApplicationRecord
  belongs_to :user
  has_many :category_notes, dependent: :destroy
  has_many :categories, through: :category_notes

  validates :comment, presence: true
  validates :language, presence: true
  validates :user_id, presence: true

  def all_categories_names
    categories.pluck(:name)
  end
end
