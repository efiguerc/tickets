class Users::Customer < User
  has_many :tickets,
    foreign_key:  :customer_id,
    class_name:   "Ticket",
    dependent:    :destroy

	enum role: {
    customer: 2  
  }

  after_initialize do
    self.role ||= 'customer'
  end
end
