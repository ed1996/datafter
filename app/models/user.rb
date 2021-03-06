class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :last_name, :first_name, presence:true, length: {maximum: 50}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  before_save :anti_spam

  #extend FriendlyId
  #friendly_id :slug_users, use: [:slugged, :history]

  do_not_validate_attachment_file_type :avatar

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
        user.first_name = data["first_name"] if user.first_name.blank?
        user.fullname = data["first_name"] if user.first_name.blank? + " " + data["last_name"] if user.last_name.blank?
        user.date_of_birth = data["date_of_birth"] if user.date_of_birth.blank?
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.image = auth.info.image
        user.fullname = auth.info.name
        user.last_name = auth.info.name
        user.first_name = auth.info.name
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.username
        user.email = auth.info.email
        user.token = auth.credentials.token
        user.expires_at = Time.at(auth.credentials.expires_at)
      end
    end
    return_user
  end

  private

  def anti_spam
    doc = Nokogiri::HTML::DocumentFragment.parse(self.description)
    doc.css('a').each do |a|
      a[:rel] = 'nofollow'
      a[:target] = '_blank'
    end
    self.description = doc.to_s
  end

  def slug_users
    "user #{first_name} #{last_name} #{Time.now}"
  end

  has_many :hommages
  has_one :memory
  has_many :messages
  has_many :animals
end
