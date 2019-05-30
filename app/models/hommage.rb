class Hommage < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :date_birth, presence: true
  validates :date_death, presence: true
  validates :burial_place, presence: true
  validates :description, presence: true, length: {maximum: 2600}
end
