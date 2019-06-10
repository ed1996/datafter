class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2] #:confirmable

  validates :last_name, :first_name, presence:true, length: {maximum: 50}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
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

  has_many :hommages
end
