class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_with_token!

  respond_to :json

  def index
    respond_with Ticket.find(params[:ticket_id]).comments
  end

  def create
    byebug
    comment = Comment.build(comment_params)
    if coment.save
      render json: comment, status: :created, location: [:api_v1, comment]
    else
      render json: { errors: comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comments).permit(:body, :ticket_id, :user_id)
  end
end
