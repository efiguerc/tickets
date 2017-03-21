class Users::Customer < User
  has_many :tickets,
    foreign_key:  :customer_id,
    class_name:   "Ticket",
    dependent:    :destroy

  after_initialize do
    self.role ||= 'customer'
  end
end
