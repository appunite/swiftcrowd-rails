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
  
  def self.create_from_twitter(twitter_user)
    user = User.find_by(twitter_uid: twitter_user.id.to_s)
    
    user = User.new unless user.present?

    user.twitter = "@#{twitter_user.screen_name}"
    user.name = twitter_user.name
    user.remote_avatar_url = twitter_user.profile_image_url
    user.website = twitter_user.attrs[:url] if twitter_user.attrs[:url].present?
    
    user
  end
  
  private
  def ensure_auth_token
    self.authentication_token ||= SecureRandom.urlsafe_base64(32)
  end
end
