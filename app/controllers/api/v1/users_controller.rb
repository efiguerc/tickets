class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!
  before_action :authorize_action

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
    user = User.find(params[:id])

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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def authorize_action
    if current_user.customer? || current_user.agent?
      render json: { errors: "Not authorized!" }, status: :unauthorized
    end
  end
end
