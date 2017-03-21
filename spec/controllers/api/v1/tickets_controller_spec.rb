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
end
