class Ticket < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :agent, class_name: 'User'
  
	enum status: {
    open:       0,
    assigned:   1,  
    closed:      2  
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
                        :priority,
                        :created_at,
                        :updated_at

  after_initialize do
    self.status   ||= 'open'
    self.priority ||= 'low'
  end
end
