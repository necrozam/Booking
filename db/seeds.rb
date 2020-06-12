# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.microposts.create!(content: content) }
end

User.create name: "Admin",
	email: "admin@mail.com",
	password: "123123",
	is_admin: true
40.times do |i|
	User.create name: Faker::Name.name,
	email: "example-#{i+1}@railstutorial.org",
	password:"123123"
end
