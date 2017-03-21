class Ticket < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer, -> { where(role: 'customer') }, class_name: 'User'
  belongs_to :agent, -> { where(role: 'agent').or(role: 'admin') }, class_name: 'User', optional: true
  
	enum status: {
    opened:     0,
    assigned:   1,  
    closed:     2  
  }

	enum priority: {
    low:      0,
    medium:   1,  
    high:     2  
  }

  validates_presence_of :customer_id,
                        :category,
                        :title,
                        :description,
                        :status,
                        :priority

  after_initialize do
    self.status   ||= 'opened'
    self.priority ||= 'low'
  end
end
