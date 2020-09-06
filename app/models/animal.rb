class Animal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :date_birth, presence: true
  validates :date_death, presence: true
  validates :description, presence: true, length: {maximum: 2600}
  validates :category, presence: true

end
