class Message < ApplicationRecord
  belongs_to :user
  has_many :recipients_messages
  before_save :anti_spam

  validates :content, presence: true, length: {maximum: 2600}
  validates :object, presence: true

  def self.search(search)
    if search
      where('content LIKE ? '\
            'OR object LIKE ?', "%#{search}%", "%#{search}%")
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
