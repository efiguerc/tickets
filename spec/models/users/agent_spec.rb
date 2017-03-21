require 'rails_helper'

RSpec.describe Users::Agent, type: :model do
  subject { described_class.new }

  describe 'relations' do
    it { is_expected.to have_many :tickets }
  end

  describe "role enum" do
    it { expect(Users::Agent.new(role: 0).admin?).to  eq true }
    it { expect(Users::Agent.new(role: 1).agent?).to  eq true }
  end

  describe 'default values' do

    it 'sets the role to customer' do
      expect(subject.role).to eq 'agent'
    end 
  end 
end
