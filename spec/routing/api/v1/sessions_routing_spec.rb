require 'rails_helper'

describe 'Sessions API routing specs' do

  it 'create a session' do
    expect(post: "/api/v1/sessions").to route_to(
      format:     :json,
      controller: "api/v1/sessions",
      action:     "create")
  end 
end
