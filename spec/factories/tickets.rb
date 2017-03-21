FactoryGirl.define do
  factory :ticket do
    category      0
    title         "Can't reach production network"
    description   "No answer when doing ping on any of the productions servers"
    status        0
    priority      1
  end

  trait :with_customer do
    after(:build) do |ticket|
      ticket.customer ||=  create(:user, role: 'customer')
    end 
  end
end
