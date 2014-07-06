class Api::V1::TokenController  < Api::BaseController
  skip_before_filter :authenticate!, only: [:create]

  def create
    creds = params["twitter"].symbolize_keys
    creds.merge!(Settings.twitter)
    client = Twitter::Client.new(creds)
    
    @user = User.create_from_twitter(client.user)

    if @user.save
      render "api/v1/user/show", locals: {user: @user}, root_key: "user"
    end
    
  end
end
