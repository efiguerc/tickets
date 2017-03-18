require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  subject{ json(response.body) }

  describe "GET #show" do
    let(:user) { create :user }

    it "returns the information about a user in hash" do
      get :show, id: user.id, format: :json

      expect(subject[:email]).to  eq user.email
      expect(response).to         have_http_status :success
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      let(:user_attributes) { attributes_for :user }

      it "renders a json representation for the user just created" do
        post :create, { user: user_attributes }, format: :json

        expect(subject[:email]).to  eq user_attributes[:email]
        expect(response).to         have_http_status :created
      end
    end

    context "when it is NOT creted" do
      let(:invalid_user_attributes) { {password: "12345678", password_confirmation: "12345678"} }

      it "renders an errors json" do
        post :create, { user: invalid_user_attributes }, format: :json

        expect(subject).to                  have_key :errors
        expect(subject[:errors][:email]).to include "can't be blank"
        expect(response).to                 have_http_status :unprocessable_entity
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:user) { create :user }

    context "when is succesfully updated" do

      it "renders the json representation for the updated user" do
        patch :update, params: { id: user.id, user: {email: "new_mail@example.com"} }, format: :json

        expect(subject[:email]).to  eq "new_mail@example.com"
        expect(response).to         have_http_status :ok
      end
    end

    context "when it is not updated" do

      it "renders an errors json" do
        patch :update, params: { id: user.id, user: {email: "bad_mail.com"} }, format: :json

        expect(subject).to                  have_key :errors
        expect(subject[:errors][:email]).to include "is invalid"
        expect(response).to                 have_http_status :unprocessable_entity
      end
    end
  end
end
