class Category < ApplicationRecord
  belongs_to :user
  has_many :category_notes
  has_many :notes, through: :category_notes

  validates :name, presence: true, uniquiness: { scope: :user }
  validates :user_id, presence: true
end
