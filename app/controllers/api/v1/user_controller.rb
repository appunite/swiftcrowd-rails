class Api::V1::UsersController < Api::BaseController
  skip_before_filter :authenticate!, only: [:create]

  def create
    
  end


end