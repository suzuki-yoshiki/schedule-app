# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

User.create!(name: "管理者",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  teacher: false)

User.create!(name: "教師A",
    email: "samplea@email.com",
    password: "password",
    password_confirmation: "password",
    teacher_uid: "ID_1000",
    category_class: "1A",
    admin: false,
    teacher: true)
    
User.create!(name: "教師B",
      email: "sampleb@email.com",
      password: "password",
      password_confirmation: "password",
      teacher_uid: "ID_2000",
      category_class: "2A"
      admin: false,
      teacher: true)
     

30.times do |n|
name  = Faker::Name.name
email = "sample-#{n+1}@email.com"
password = "password"
student_uid = "ID_#{n+3000}"
User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    student_uid: student_uid,
    admin: false,
    teacher: false)
end

puts "Users Created"

admin_user = User.first
guest_user = User.find(2)

@users = User.order(:created_at).take(1)
2.times do |n|
  title = Faker::Lorem.sentence(2)
  description = Faker::Lorem.sentence(2)
  @users.each { |user| user.schedules.create!(title: title, description: description) }
  admin_user.schedules.create!(title: title, description: description)
  guest_user.schedules.create!(title: title, description: description)
end

puts "Schedules Created"