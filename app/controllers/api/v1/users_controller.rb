class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]

  respond_to :json

  def index
    respond_with User.all
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, location: [:api_v1, user]
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: :ok, location: [:api_v1, user]
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
