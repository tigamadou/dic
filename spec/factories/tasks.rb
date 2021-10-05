FactoryBot.define do
    factory :task do
      name { Faker::Lorem.sentence }
      content { Faker::Lorem.paragraph }
      deadline { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
      status { Faker::Lorem.word }
    end
  end