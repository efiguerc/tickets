Rails.application.routes.draw do

  devise_for :users

  # FRONTEND
  root 'pages#app'

  # API DEFINITION
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tickets, only: [:show, :index, :create, :update, :destroy]
    end
  end
end
