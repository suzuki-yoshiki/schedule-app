# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

User.create!(name: "校長",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  teacher: false)

User.create!(name: "教師A",
    email: "samplea@email.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    teacher: true)
    
User.create!(name: "教師B",
      email: "sampleb@email.com",
      password: "password",
      password_confirmation: "password",
      admin: false,
      teacher: true)
     

50.times do |n|
name  = Faker::Name.name
email = "sample-#{n+1}@email.com"
password = "password"
User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: false,
    teacher: false)
end

admin_user = User.first
guest_user = User.find(2)

@users = User.order(:created_at).take(3)
3.times do |n|
  title = Faker::Lorem.sentence(2)
  description = Faker::Lorem.sentence(5)
  @users.each { |user| user.schedules.create!(title: title, description: description) }
  admin_user.schedules.create!(title: title, description: description)
  guest_user.schedules.create!(title: title, description: description)
end