require "time"

FactoryBot.define do
    factory :task do
      name {'Test task'}
      content {'Test task content'}
      expired_at  {Time.now}
      status {'done'}
    end
  end