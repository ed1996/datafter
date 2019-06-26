class Message < ApplicationRecord
  belongs_to :user
  has_many :recipients_messages
  before_save :anti_spam

  validates :object, presence: true
  validates :content, presence: true, length: {maximum: 2600}

  def self.search(search)
    if search
      where('content LIKE ? '\
            'OR content LIKE ?', "%#{search}%", "%#{search}%")
    end
  end

  def anti_spam
    doc = Nokogiri::HTML::DocumentFragment.parse(self.content)
    doc.css('a').each do |a|
      a[:rel] = 'nofollow'
      a[:target] = '_blank'
    end
    self.content = doc.to_s
  end
end
