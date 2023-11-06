class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
