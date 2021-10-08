FactoryBot.define do
  factory :tag do
    title { Faker::Lorem.word }
  end
end

def task_with_tags(posts_count: 5)
  FactoryBot.create(:task) do |user|
    FactoryBot.create_list(:tags, posts_count, tag: tag)
  end
end