class Hommage < ApplicationRecord
  belongs_to :user
  has_many :photos
  html_schema_type :Person
  before_save :anti_spam

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :date_birth, presence: true
  validates :date_death, presence: true
  validates :burial_place, presence: true
  validates :description, presence: true, length: {maximum: 2600}

  extend FriendlyId
  friendly_id :slug_hommages, use: [:slugged, :history]

  Hommage.html_schema_type # => Mida::SchemaOrg::BlogPosting
  Hommage.new.html_schema_type # => Mida::SchemaOrg::BlogPosting

  def self.search(search)
    if search
      where('last_name LIKE ? '\
            'OR first_name LIKE ?', "%#{search}%", "%#{search}%")
    end
  end

  def anti_spam
    doc = Nokogiri::HTML::DocumentFragment.parse(self.description)
    doc.css('a').each do |a|
      a[:rel] = 'nofollow'
      a[:target] = '_blank'
    end
    self.description = doc.to_s
  end

  def slug_hommages
    "#{last_name} #{first_name} #{Time.now}"
  end
end
