User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "111111",
  password_confirmation: "111111",
  role: 0)

User.create!(name: "Librarian",
  email: "librarian@gmail.com",
  password: "111111",
  password_confirmation: "111111",
  role: 1)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "111111"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 2)
end

10.times do |n|
  name = Faker::Book.author
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone
  Author.create!(name: name,
    address: address,
    phone: phone)
end

10.times do |n|
  category = Faker::Book.genre
  Category.create!(name: category)
end

10.times do |n|
  publisher = Faker::Book.publisher
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone
  Publisher.create!(name: publisher,
    address: address,
    phone: phone)
end

Card.create!(issued_date: Date.parse("2018-07-25"),
  expired_date: Date.parse("2019-01-02"),
  user_id: 3)
