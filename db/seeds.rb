# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = [
  'hello@robertz.co',
  'test1@robertz.co',
  'test3@robertz.co',
  'test4@robertz.co',
  'test5@robertz.co',
  'test6@robertz.co',
  'test7@robertz.co',
  'test8@robertz.co',
  'test9@robertz.co',
  'test10@robertz.co',
  'test11@robertz.co',
  'test12@robertz.co',
]

emails.each do |email|
  next if User.find_by_email(email)
  User.create(email: email, password: '12345678')
  puts "New user with email (#{email}) created!"
end
