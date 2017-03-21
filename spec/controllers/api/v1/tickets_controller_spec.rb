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
end
