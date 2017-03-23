class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_with_token!

  respond_to :json

  def index
    respond_with Ticket.find(params[:ticket_id]).comments
  end
end
