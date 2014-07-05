class Api::V1::UsersController < Api::BaseController

  def index
    @users = User.where(id: params[:uuids])
  end

end