class Api::V1::UsersController < Api::BaseController

  def index
    @users = User.where(uuid: params[:uuids])
  end

end