class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]


  has_many :notes
  has_many :categories

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(name: data['first_name'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
