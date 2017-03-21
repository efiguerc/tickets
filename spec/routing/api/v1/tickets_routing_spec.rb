require 'rails_helper'

describe 'Tickets API routing specs' do

  it 'show a ticket' do
    expect(get: "/api/v1/tickets/1").to route_to(
      format:     :json,
      controller: "api/v1/tickets",
      action:     "show",
      id:         '1')
  end 

  it 'get all tickets' do
    expect(get: "/api/v1/tickets").to route_to(
      format:     :json,
      controller: "api/v1/tickets",
      action:     "index")
  end 
end
