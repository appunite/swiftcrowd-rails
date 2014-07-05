Rails.application.routes.draw do
  get 'landings/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resource :user, only: [:show, :update, :create]
    end
  end
  

  root 'landings#index'
end
