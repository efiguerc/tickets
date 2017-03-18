require 'rails_helper'

describe 'Users API routing specs' do
  it 'show a user' do
    expect(get: "/api/v1/users/1").to route_to(
      format:     :json,
      controller: "api/v1/users",
      action:     "show",
      id:         '1')
  end 
end
