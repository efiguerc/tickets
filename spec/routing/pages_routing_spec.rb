require 'rails_helper'

describe 'Pages specs' do

  it 'get to the app' do
    expect(get: "/").to route_to(
      controller: "pages",
      action:     "app")
  end 
end
