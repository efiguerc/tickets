require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a user in hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(user_response[:email]).to eq @user.email
    end

  it { should respond_with 200 }
  end
end
