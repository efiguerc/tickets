require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new }

  describe 'relations' do
    it { is_expected.to belong_to :ticket }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ticket_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:body) }
  end 
end
