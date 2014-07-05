class User < ActiveRecord::Base

  # validations
  validates :name, presence: true

  # callbacks
  before_save :ensure_auth_token

  # carrierwave
  mount_uploader :avatar, AvatarUploader

  def find_by_authentication_token token
    User.find_by(authentication_token: token)
  end
  
  private
  def ensure_auth_token
    self.authentication_token ||= SecureRandom.urlsafe_base64(32)
  end
end
