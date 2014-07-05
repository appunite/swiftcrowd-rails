class Api::V1::UsersController < Api::BaseController

  def index
    User.where(uuid: params[:uuid])
  end


end