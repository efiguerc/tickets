class Api::V1::SessionsController < ApplicationController

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]

    user = user_email.present? && User.find_by(email: user_email)
    p "app"
    p user

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_access_token!
      user.save
      render json: user, status: :ok, location: [:api_v1, user]
    else
      render json: { errors: "Invalid email or password" }, status: :unprocessable_entity
    end
  end
end
