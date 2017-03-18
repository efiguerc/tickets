require 'api_constraints'

Rails.application.routes.draw do
  # devise_for :users

  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create]
    end
  end
end
