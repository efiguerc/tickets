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

  it 'create a ticket' do
    expect(post: "/api/v1/tickets").to route_to(
      format:     :json,
      controller: "api/v1/tickets",
      action:     "create")
  end 

  it 'update a ticket' do
    expect(patch: "/api/v1/tickets/1").to route_to(
      format:     :json,
      controller: "api/v1/tickets",
      action:     "update",
      id:         '1')
  end 
  it 'update a ticket' do

    expect(delete: "/api/v1/tickets/1").to route_to(
      format:     :json,
      controller: "api/v1/tickets",
      action:     "destroy",
      id:         '1')
  end 
end
