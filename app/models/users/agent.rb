class Users::Agent < User
  has_many :tickets,
    foreign_key:  :agent_id,
    class_name:   "Ticket"

  after_initialize do
    self.role ||= 'agent'
  end
end
