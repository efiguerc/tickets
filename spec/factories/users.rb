FactoryGirl.define do
  factory :user do
    sequence :email do |n| 
      Faker::Internet.email
    end
    password "12345678"
    password_confirmation "12345678"
  end

  factory :customer, class: Users::Customer do
    email { Faker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
  end
end
