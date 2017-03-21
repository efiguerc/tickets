class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets, as: :customer
  has_many :tickets, as: :agent

	enum role: {
    admin:      0,
    agent:      1,  
    customer:   2  
  }

  validates :access_token, uniqueness: true
  validates_presence_of :role

  before_create :generate_access_token!

  def generate_access_token!
    begin
      self.access_token = Devise.friendly_token
    end while self.class.exists?(access_token: access_token)
  end
end
