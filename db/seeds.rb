# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

user_list = [
  ['admin', 'administrator', 'admin@example.com', 'password', 'en'],
  ['Test', 'TestLastName', 'test@wolox.com.ar', '123123123', 'en'],
  ['Mariano', 'Ranucci', 'mariano.ranucci@wolox.com.ar', '456456456', 'es']
]

user_list.each do |first_name, last_name, email, password, locale|
  User.create(first_name: first_name, last_name: last_name, email: email, password: password,
              password_confirmation: password, locale: locale)
end

FactoryBot.create_list(:book, 5)
