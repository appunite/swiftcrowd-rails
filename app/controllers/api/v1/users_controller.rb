class Api::V1::UsersController < Api::BaseController
  skip_before_filter :authenticate!, only: [:index]

  def index
    @users = User.where(id: params[:uuids])
  end

end