require 'faker'

comments = Comment.with_deleted
comments.each { |comment| comment.really_destroy! }

tickets = Ticket.with_deleted
tickets.each { |ticket| ticket.really_destroy! }

users = User.with_deleted
users.each { |user| user.really_destroy! }

admin = User.create!(
  name:                   "Admin",
  email:                  "admin@example.com",
  password:               "12345678",
  password_confirmation:  "12345678",
  role:                   "admin"
)

agent = User.create!(
  name:                   "Agent",
  email:                  "agent@example.com",
  password:               "12345678",
  password_confirmation:  "12345678",
  role:                   "agent"
)

customer = User.create!(
  name:                   "Customer",
  email:                  "customer@example.com",
  password:               "12345678",
  password_confirmation:  "12345678",
  role:                   "customer"
)

10.times do |n| 
  name = Faker::Name.first_name
  User.create!(
    name:                   name,
    email:                  "#{name}@example.com",
    password:               "12345678",
    password_confirmation:  "12345678",
    role:     case n % 3
                when 0 then 'admin'
                when 1 then 'agent'
                when 2 then 'customer'
              end
  )
end

Ticket.create!(
  id:           0,
  category:     "Network",
  title:        "Network unreachable.",
  description:  "No answer from any production server when doing ping.",
  status:       "opened",
  priority:     "low",
  customer_id:  customer.id,
  agent:        nil
)


customers =  User.where(role: "customer").pluck :id
agents =  User.where(role: "agent").pluck :id
10.times do |n| 
  status =  case n % 3
              when 0 then 'opened'
              when 1 then 'assigned'
              when 2 then 'closed'
            end
  priority =  case n % 3
                when 0 then 'low'
                when 1 then 'medium'
                when 2 then 'high'
              end
  if status == "assigned"
    agent = agents[n % agents.count]
  else
    agent = nil
  end

  Ticket.create!(
    category:     "Network",
    title:        "#{n} Network unreachable.",
    description:  "No answer from any production server when doing ping.",
    status:       status,
    priority:     priority,
    customer_id:  customers[n % customers.count],
    agent_id:     agent
  )
end

tickets =  Ticket.where(status: 'assigned')
tickets_count = tickets.count
15.times do |index| 

  ticket =  tickets[ index % tickets_count ]
  user =  case index % 2
            when 0 then ticket.agent
            when 1 then ticket.customer
          end

  Comment.create!(
    ticket_id:    ticket.id,
    user_id:      user.id,
    body:         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  )
end
