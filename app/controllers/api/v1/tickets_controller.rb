class Api::V1::TicketsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  respond_to :json

  def show
    respond_with Ticket.find(params[:id])
  end

  def index
    respond_with Ticket.all
  end

  def create
    ticket = current_user.opened_tickets.build(ticket_params)
    if ticket.save
      render json: ticket, status: :created, location: [:api_v1, ticket]
    else
      render json: { errors: ticket.errors }, status: :unprocessable_entity
    end
  end

  def update
    ticket = current_user.opened_tickets.find(params[:id])
    if ticket.update(ticket_params)
      render json: ticket, status: :ok, location: [:api_v1, ticket]
    else
      render json: { errors: ticket.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    ticket = current_user.opened_tickets.find(params[:id])
    ticket.destroy
    head :no_content
  end

  private

  def ticket_params
    params.require(:ticket).permit(:category, :title, :description, :priority, :customer_id)
  end
end
