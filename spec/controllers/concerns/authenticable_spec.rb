require 'rails_helper'

RSpec.describe Authenticable do
  let(:authentication) {
    class Authentication 
      include Authenticable
      def request
      end
    end
    Authentication.new
  }

  describe '#current_user' do
    let(:user) { create(:user) }

    before do
      request.headers["Authorization"] = user.access_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it "returns the corresponding user" do
      expect(authentication.current_user.access_token).to eq user.access_token
    end
  end
end
