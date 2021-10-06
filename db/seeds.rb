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
