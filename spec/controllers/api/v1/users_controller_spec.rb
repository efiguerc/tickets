require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create :user, role: 0 }

  describe "GET #show" do

    it "returns the information about a user in hash" do
      get :show, params: { id: user.id }

      expect(json_response[:email]).to  eq user.email
      expect(response).to         have_http_status :success
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      let(:user_attributes) { attributes_for :user, role: 0 }

      it "renders a json representation for the user just created" do
        post :create, params: { user: user_attributes }

        expect(json_response[:email]).to  eq user_attributes[:email]
        expect(response).to         have_http_status :created
      end
    end

    context "when it is NOT creted" do
      let(:invalid_user_attributes) { {password: "12345678", password_confirmation: "12345678"} }

      it "renders an errors json" do
        post :create, params: { user: invalid_user_attributes }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors][:email]).to include "can't be blank"
        expect(response).to                 have_http_status :unprocessable_entity
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      api_authorization_header user.access_token
    end

    context "when is succesfully updated" do
      it "renders the json representation for the updated user" do
        patch :update, params: { id: user.id, user: {email: "new_mail@example.com"} }

        expect(json_response[:email]).to  eq "new_mail@example.com"
        expect(response).to         have_http_status :ok
      end
    end

    context "when it is not updated" do

      it "renders an errors json" do
        patch :update, params: { id: user.id, user: {email: "bad_mail.com"} }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors][:email]).to include "is invalid"
        expect(response).to                 have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      api_authorization_header user.access_token
    end

    it "responds with :no_content status" do
      delete :destroy, params: { id: user.id }

      expect(response).to have_http_status :no_content
    end
  end
end
