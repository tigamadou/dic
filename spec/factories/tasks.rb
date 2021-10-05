FactoryBot.define do
    factory :task do
      name {'Test task'}
      content {'Test task content'}
      exprired_at  {DateTime}
      status {'done'}
    end
  end