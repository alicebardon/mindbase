class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :notes, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    if user
      user.update(access_token: access_token['credentials']['token'])
    else
      name = data["name"]&.split(" ")&.first || data["nickname"]
      user = User.create(first_name: name,
          email: data['email'],
          access_token: access_token['credentials']['token'],
          password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
