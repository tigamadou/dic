FactoryBot.define do
  factory :user do
    name { Faker::Games::Pokemon.name }
    email { Faker::Internet.email}
    password { Faker::Internet.password }
    role { 'default'}
  end

  factory :admin, class: User do
    name { Faker::Games::Pokemon.name }
    email { Faker::Internet.email}
    password { Faker::Internet.password}
    role { 'admin' }
  end
end
