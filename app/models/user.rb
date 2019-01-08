class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
