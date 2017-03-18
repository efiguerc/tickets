require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
    let!(:user) { create(:user) }

    context "when the credentials are correct" do
      let(:credentials) { { email: user.email, password: "12345678" } }

      it "returns the corresponding user" do
        p "spec"
        p user
        post :create, params: { session: credentials }
        user.reload

        expect(json_response[:access_token]).to eq user.access_token
        expect(response).to                     have_http_status :ok
      end 
    end

    context "when credentials are incorrect" do
      let(:credentials) { { email: user.email, password: "invalidpassword" } }

      it "return a json with an error" do
        post :create, params: { session: credentials }
        
        expect(json_response[:errors]).to eq "Invalid email or password"
        expect(response).to               have_http_status :unprocessable_entity
      end
    end
  end
end
