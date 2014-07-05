class Api::V1::UserController < Api::BaseController
  skip_before_filter :authenticate!, only: [:create]

  def create
    @user = User.new(user_params)
    
    if @user.save
      show
    else
      api_error!(:cant_save, "Can't create user")
    end
  end

  def update
    @user = current_user
    
    if @user.update(user_params)
      show
    else
      api_error!(:cant_save, "Can't update user")
    end
  end
  
  def show
    @user = current_user
    
    show
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :avatar, :birthdate, :twitter, :facebook, :github, :website)
  end
  
  def show
    render 'api/v1/user/show', locals: { user: @user }
  end

end