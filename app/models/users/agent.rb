class Users::Agent < User
  has_many :tickets,
    foreign_key:  :agent_id,
    class_name:   "Ticket"

	enum role: {
    admin:  0,
    agent:  1
  }

  after_initialize do
    self.role ||= 'agent'
  end
end
