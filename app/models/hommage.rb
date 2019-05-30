class Hommage < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :Nom, presence: true
  validates :Prenom, presence: true
  validates :date_naissance, presence: true
  validates :date_deces, presence: true
  validates :lieu_enterrement, presence: true
  validates :description, presence: true, length: {maximum: 2600}

  def self.search(search)
    if search
      where('last_name LIKE ?', "%#{search}%")
    else

    end
  end
end
