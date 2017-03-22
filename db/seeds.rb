Ticket.delete_all
User.delete_all

user = User.create!(
  email:                  "foo.bar@example.com",
  password:               "12345678",
  password_confirmation:  "12345678",
  role:                   "customer"
)

Ticket.create!(
  id:           0,
  category:     "Network",
  title:        "Network unreachable.",
  description:  "No answer from any production server when doing ping.",
  status:       "opened",
  priority:     "low",
  customer_id:  user.id,
  agent:        nil
)

10.times do |n| 
  Ticket.create!(
    category:     "Network",
    title:        "#{n} Network unreachable.",
    description:  "No answer from any production server when doing ping.",
    status:       case n % 3
                    when 0 then 'opened'
                    when 1 then 'assigned'
                    when 2 then 'closed'
                  end,
    priority:     case n % 3
                    when 0 then 'low'
                    when 1 then 'medium'
                    when 2 then 'high'
                  end,
    customer_id:  user.id,
    agent:        nil
  )
end
