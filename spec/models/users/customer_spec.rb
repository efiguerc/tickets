require 'rails_helper'

RSpec.describe Users::Customer, type: :model do
  let(:customer) { build(:customer) }

  subject { customer }

  describe 'relations' do
    it { is_expected.to have_many :tickets }
  end

  describe "role enum" do
    it { expect(Users::Customer.new(role: 2).customer?).to  eq true }
  end

  describe 'default values' do

    it 'sets the role to customer' do
      expect(subject.role).to eq 'customer'
    end 
  end 

  describe "#tickets association" do
    before do
      customer.save
      3.times { create(:ticket, customer: customer) }
    end

    it "destroys the associated tickets on self destruct" do
      tickets = customer.tickets
      customer.destroy
      tickets.each do |ticket|
        expect { Ticket.find(ticket) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
