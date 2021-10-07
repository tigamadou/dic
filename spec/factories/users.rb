FactoryBot.define do
  factory :user do
    name { "Default User" }
    email { "default@default.com" }
    password { "123456" }
    role { 'default'}
  end

  factory :admin do
    name { "Admin User" }
    email { "admin@admin.com" }
    password { "123456" }
    role { 'admin' }
  end
end
