require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create :user, role: "customer" }

  describe "GET #show" do

    context "when user NOT authenticated" do

      it "renders an errors json" do
        get :show, params: { id: user.id }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors]).to include "Not authenticated"
        expect(response).to                       have_http_status :unauthorized
      end
    end

    context "when user is authenticated" do
      before(:each) do
        api_authorization_header requester.access_token
        get :show, params: { id: user.id }
      end

      context "when current_user is a customer" do
        let(:requester) { create :user, role: "customer" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is an agent" do
        let(:requester) { create :user, role: "agent" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is an admin" do
        let(:requester) { create :user, role: "admin" }

        it "returns the information about a user in hash" do
          expect(json_response[:email]).to  eq user.email
          expect(response).to               have_http_status :success
        end
      end
    end
  end

  describe "POST #create" do
    let(:user_attributes) { attributes_for :user, role: "customer" }

    context "when user NOT authenticated" do

      it "renders an errors json" do
        post :create, params: { user: user_attributes }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors]).to include "Not authenticated"
        expect(response).to                       have_http_status :unauthorized
      end
    end

    context "when user is authenticated" do
      before(:each) do
        api_authorization_header requester.access_token
        post :create, params: { user: user_attributes }
      end

      context "when current_user is a customer" do
        let(:requester) { create :user, role: "customer" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a agent" do
        let(:requester) { create :user, role: "agent" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a admin" do
        let(:requester) { create :user, role: "admin" }

        context "when is successfully created" do

          it "renders a json representation for the user just created" do
            expect(json_response[:email]).to  eq  user_attributes[:email]
            expect(response).to                   have_http_status :created
          end
        end

        context "when it is NOT creted" do
          let(:user_attributes) { {password: "12345678", password_confirmation: "12345678"} }

          it "renders an errors json" do
            expect(json_response).to                  have_key :errors
            expect(json_response[:errors][:email]).to include "can't be blank"
            expect(response).to                       have_http_status :unprocessable_entity
          end
        end
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:user) { create :user, role: "customer" }

    context "when user NOT authenticated" do

      it "renders an errors json" do
        patch :update, params: { id: user.id, user: {email: "new_mail@example.com"} }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors]).to include "Not authenticated"
        expect(response).to                       have_http_status :unauthorized
      end
    end

    context "when user is authenticated" do
      let(:user_attributes) { {email: "new_mail@example.com"} }

      before(:each) do
        api_authorization_header requester.access_token
        patch :update, params: { id: user.id, user: user_attributes }
      end

      context "when current_user is a customer" do
        let(:requester) { create :user, role: "customer" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a agent" do
        let(:requester) { create :user, role: "agent" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a admin" do
        let(:requester) { create :user, role: "admin" }

        context "when is succesfully updated" do
          it "renders the json representation for the updated user" do
            patch :update, params: { id: user.id, user: {email: "new_mail@example.com"} }

            expect(json_response[:email]).to  eq "new_mail@example.com"
            expect(response).to         have_http_status :ok
          end
        end

        context "when it is not updated" do
          let(:user_attributes) { {email: "bad_mail.com"} }

          it "renders an errors json" do
            expect(json_response).to                  have_key :errors
            expect(json_response[:errors][:email]).to include "is invalid"
            expect(response).to                 have_http_status :unprocessable_entity
          end
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create :user, role: "customer" }

    context "when user NOT authenticated" do

      it "renders an errors json" do
        delete :destroy, params: { id: user.id }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors]).to include "Not authenticated"
        expect(response).to                       have_http_status :unauthorized
      end
    end

    context "when user is authenticated" do

      before(:each) do
        api_authorization_header requester.access_token
        delete :destroy, params: { id: user.id }
      end

      context "when current_user is a customer" do
        let(:requester) { create :user, role: "customer" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a agent" do
        let(:requester) { create :user, role: "agent" }

        it "renders an errors json" do
          expect(json_response).to                  have_key :errors
          expect(json_response[:errors]).to include "Not authorized!"
          expect(response).to                       have_http_status :unauthorized
        end
      end

      context "when current_user is a admin" do
        let(:requester) { create :user, role: "admin" }

        context "when is NOT his own account" do

          it "responds with :no_content status" do
            expect(response).to have_http_status :no_content
          end
        end

        context "when is his own account" do
          let(:user) { requester }

          it "renders an errors json" do
            p user
            p requester
            expect(json_response).to                  have_key :errors
            expect(json_response[:errors]).to include "Not authorized!"
            expect(response).to                       have_http_status :unauthorized
          end
        end
      end
    end
  end
end
