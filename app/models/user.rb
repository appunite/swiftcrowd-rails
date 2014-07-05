class User < ActiveRecord::Base

  def find_by_authentication_token token
    User.find_by(authentication_token: token)
  end
end
