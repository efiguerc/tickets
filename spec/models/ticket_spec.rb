require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { described_class.new }

  it { is_expected.to respond_to(:customer_id) }
  it { is_expected.to respond_to(:category) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:priority) }
  it { is_expected.to respond_to(:agent_id) }

  describe 'default values' do
    it 'sets the status to open' do
      expect(subject.status).to eq 'open'
    end 

    it 'sets the priority to low' do
      expect(subject.priority).to eq 'low'
    end 
  end 

  describe 'validations' do
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end 

  describe "status enum" do
    it { expect(Ticket.new(status: 0).open?).to       eq true }
    it { expect(Ticket.new(status: 1).assigned?).to   eq true }
    it { expect(Ticket.new(status: 2).closed?).to     eq true }
  end

  describe "priority enum" do
    it { expect(Ticket.new(priority: 0).low?).to      eq true }
    it { expect(Ticket.new(priority: 1).medium?).to   eq true }
    it { expect(Ticket.new(priority: 2).high?).to     eq true }
  end
end
