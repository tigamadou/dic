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
user = User.create!(name: name, email: email,password: password)
user.tasks.create(name: 'First Task', content: 'This the first task content', expired_at: DateTime.now, status:'uncompleted', priority: 'low')

# 10.times{ |i| u= User.create!(name: `User #{i}`, email: `johndoe#{i}@domain.com`,password: password)}

10.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "123456"
    user = User.create!(Faker::Internet.user('name', 'email', 'password'))
    3.times do |y|
        status= ['unstarted','in_progress','completed']
        priorities= ['low','medium','hight']
        user.tasks.create(
                            name: Faker::Lorem.sentence,
                            content: Faker::Lorem.paragraph,
                            expired_at: DateTime.now,
                            status: status.sample
                            )
    end
  end
