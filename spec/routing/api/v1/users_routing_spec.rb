require 'rails_helper'

describe 'Users API routing specs' do
  it 'show a user' do
    expect(get: "/api/v1/users/1").to route_to(
      format:     :json,
      controller: "api/v1/users",
      action:     "show",
      id:         '1')
  end 

  it 'create a user' do
    expect(post: "/api/v1/users").to route_to(
      format:     :json,
      controller: "api/v1/users",
      action:     "create")
  end 

  it 'update a user' do
    expect(patch: "/api/v1/users/1").to route_to(
      format:     :json,
      controller: "api/v1/users",
      action:     "update",
      id:         '1')
  end 

  it 'destroy a user' do
    expect(delete: "/api/v1/users/1").to route_to(
      format:     :json,
      controller: "api/v1/users",
      action:     "destroy",
      id:         '1')
  end 
end
