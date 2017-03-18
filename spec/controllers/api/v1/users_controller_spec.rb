require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #show" do
    let(:user) { FactoryGirl.create :user }

    it "returns the information about a user in hash" do
      get :show, id: user.id, format: :json
      user_response = json(response.body)

      expect(user_response[:email]).to eq user.email
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      let(:user_attributes) { FactoryGirl.attributes_for :user }

      it "renders a json representation for the user just created" do
        post :create, { user: user_attributes }, format: :json
        user_response = json(response.body)

        expect(user_response[:email]).to eq user_attributes[:email]
        expect(response).to have_http_status(:success)
      end
    end

    context "when it is NOT creted" do
      let(:invalid_user_attributes) { {password: "12345678", password_confirmation: "12345678"} }

      it "renders an errors json" do
        post :create, { user: invalid_user_attributes }, format: :json
        user_response = json(response.body)

        expect(user_response[:errors][:email]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
