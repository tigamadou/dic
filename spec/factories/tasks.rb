FactoryBot.define do
    factory :task do
      name {'Test task'}
      content {'Test task content'}
      deadline  {DateTime}
      status {'done'}
    end
  end