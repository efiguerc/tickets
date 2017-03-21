require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, role: 0) }

  subject { user }

  describe 'relations' do
    it { is_expected.to have_many :opened_tickets }
    it { is_expected.to have_many :assigned_tickets }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('example@domain.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:access_token) }
    it { is_expected.to validate_presence_of(:role) }
  end 

  describe "role enum" do
    it { expect(User.new(role: 0).admin?).to      eq true }
    it { expect(User.new(role: 1).agent?).to      eq true }
    it { expect(User.new(role: 2).customer?).to   eq true }
  end

  describe "when email is not present" do
    before { user.email = " " }
    it { is_expected.not_to be_valid }
  end

  describe "#generate_access_token!" do

    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      user.generate_access_token!
      expect(subject.access_token).to eq "auniquetoken123"
    end

    context "when a token already has been taken" do
      let!(:existing_user) { create(:user, access_token: "auniquetoken123", role: 0) }

      it "generates another token" do
        user.generate_access_token!
        expect(subject.access_token).not_to eq existing_user.access_token
      end
    end
  end

  describe "#tickets association" do
    before do
      user.save
      3.times { create(:ticket, customer: user) }
    end

    it "destroys the associated tickets on self destruct" do
      tickets = user.opened_tickets
      user.destroy
      tickets.each do |ticket|
        expect { Ticket.find(ticket) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
