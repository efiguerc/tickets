require 'rails_helper'

RSpec.describe Authenticable do
  let(:authentication) {
    class Authentication 
      include Authenticable
      def request
      end
      def response
      end
    end
    Authentication.new
  }
  let(:user) { create(:user) }

  describe '#current_user' do
    before do
      request.headers["Authorization"] = user.access_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it "returns the corresponding user" do
      expect(authentication.current_user.access_token).to eq user.access_token
    end
  end

  describe '#authenticate_with_token' do
    before do
      allow(authentication).to receive(:current_user).and_return(nil)
      allow(response).to receive(:response_code).and_return(401)
      allow(response).to receive(:body).and_return({ errors: "Not authenticated" }.to_json)
      allow(authentication).to receive(:response).and_return(response)
    end

    it "renders a json error message" do
      expect(json_response[:errors]).to  eq "Not authenticated"
      expect(authentication).to respond_with :unauthorized
    end
  end
end
