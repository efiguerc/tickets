require 'rails_helper'

describe 'Sessions API routing specs' do

  it 'create a session' do
    expect(post: "/api/v1/sessions").to route_to(
      format:     :json,
      controller: "api/v1/sessions",
      action:     "create")
  end 

  it 'destroy a session' do
    expect(delete: "/api/v1/sessions/1").to route_to(
      format:     :json,
      controller: "api/v1/sessions",
      action:     "destroy",
      id:         "1")
  end 
end
