require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  
  describe "GET #show" do
    let(:ticket) { create(:ticket, :with_customer) }

    it "returns the corresponding ticket data in a hash" do
      get :show, params: { id: ticket.id }

      expect(json_response[:title]).to  eq ticket.title
      expect(response).to               have_http_status :ok
    end
  end

  describe "GET #index" do
    let!(:tickets) { create_list(:ticket, 4) }

    it "returns 4 records from the database" do
      get :index

      expect(json_response.size).to   eq 4
      expect(response).to             have_http_status :ok
    end
  end

  describe "POST #create" do
    let(:user) { create(:user, role: 'customer') }
    let(:ticket_attributes) { attributes_for(:ticket) }

    before(:each) do
      api_authorization_header user.access_token
    end

    context "when is succesfully created" do
      
      it "renders the json representation for the ticket" do
        post :create, params: { customer_id: user.id, ticket: ticket_attributes }

        expect(json_response[:title]).to  eq ticket_attributes[:title]
        expect(response).to               have_http_status :created
      end
    end

    context "when is not created" do

      it "renders an errors json" do
        ticket_attributes[:title] = ""
        post :create, params: { customer_id: user.id, ticket: ticket_attributes }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors][:title]).to include "can't be blank"
        expect(response).to                       have_http_status :unprocessable_entity
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:ticket) { create(:ticket) }
    
    before(:each) do
      api_authorization_header ticket.customer.access_token
    end

    context "when is succesfully updated" do

      it "renders the json representation for the updated ticket" do
        patch :update, params: { id: ticket.id, ticket: { title: "A new title" } }

        expect(json_response[:title]).to  eq "A new title"
        expect(response).to               have_http_status :ok
      end
    end

    context "when is not updated" do

      it "renders an errors json" do
        patch :update, params: { id: ticket.id, ticket: { title: "" } }

        expect(json_response).to                  have_key :errors
        expect(json_response[:errors][:title]).to include "can't be blank"
        expect(response).to                       have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE #destroy" do
    let(:ticket) { create(:ticket) }
    
    before(:each) do
      api_authorization_header ticket.customer.access_token
    end
    
    it "is succesfully destroyed" do
      delete :destroy, params: { id: ticket.id }

      expect(response).to have_http_status :no_content
    end
  end
end
