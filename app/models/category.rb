class Category < ApplicationRecord
  belongs_to :user
  has_many :category_notes, dependent: :destroy
  has_many :notes, through: :category_notes

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :user_id, presence: true
end
