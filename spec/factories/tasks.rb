require "time"

FactoryBot.define do
    factory :task do
      name { Faker::Games::Pokemon.name }
      content { Faker::Games::Pokemon.name }
      expired_at  {Time.now}
      status {'unstarted'}
      user_id { 1 }
    end
  end