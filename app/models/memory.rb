class Memory < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: {maximum: 2600}
  validates :receivers, presence: true, length: {maximum: 2600}
end
