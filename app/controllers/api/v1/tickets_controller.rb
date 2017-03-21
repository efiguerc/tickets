class Api::V1::TicketsController < ApplicationController
  respond_to :json

  def show
    respond_with Ticket.find(params[:id])
  end

  def index
    respond_with Ticket.all
  end
end
