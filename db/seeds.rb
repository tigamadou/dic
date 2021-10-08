# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
name = 'John DOe'
email = 'johndoe@domain.com'
password = "123456"
user = User.create!(name: name, email: email,password: password, role: 'admin')
user.tasks.create(name: 'First Task', content: 'This the first task content', expired_at: DateTime.now, status:'unstarted', priority: 'low')


10.times do |y|
  Tag.create(title: Faker::Lorem.word);
  User.create(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: 'default'
  )
end
tags = [1,2,3]

User.all.each do |user|

  10.times do |y|
      status= ['unstarted','in_progress','completed']
      priorities= ['low','medium','hight']
      task = user.tasks.create(
                          name: Faker::Lorem.sentence,
                          content: Faker::Lorem.paragraph,
                          expired_at: DateTime.now,
                          status: status.sample
                          )
      Tagging.create(tag_id: Tag.all.pluck(:id).sample, task_id: task.id)
      
      
  end
end




  