class Memory < ApplicationRecord
  belongs_to :user
  has_many :recipients_memories

  validates :body, presence: true, length: {maximum: 2600}
end
