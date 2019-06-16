class Hommage < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :date_birth, presence: true
  validates :date_death, presence: true
  validates :burial_place, presence: true
  validates :description, presence: true, length: {maximum: 2600}

  extend FriendlyId
  friendly_id :slug_hommages, use: :slugged

  def self.search(search)
    if search
      where('last_name LIKE ? '\
            'OR first_name LIKE ?', "%#{search}%", "%#{search}%")
    else

    end
  end

  def slug_hommages
    [
        [:last_name, :first_name],
    ]
  end
end
