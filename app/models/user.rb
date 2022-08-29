class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notes
  has_many :categories

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :password, length: {minimum: 6}
  validates :first_name, presence: true
end
