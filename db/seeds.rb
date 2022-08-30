# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning DB..."
CategoryNote.destroy_all
User.find(1234).destroy if User.find(1234).valid?
Note.destroy_all
Category.destroy_all

test_user = User.create(id: 1234, email: "user@test.com", password: "1234567", first_name: "test")

puts "Creating notes..."
note1 = Note.create(
  file_path: "/projects/rails_project/app/controllers/page_controller.rb",
  language: "ruby",
  user: test_user,
  code_content: "class PagesController < ApplicationController",
  content: "This is how you intert from a parent class"
)

note2 = Note.create(
  file_path: "/projects/rails_project/app/controllers/routes.rb",
  language: "ruby",
  user: test_user,
  code_content: "resources :hello do",
  content: "This is how you start nested resources"
)

note3 = Note.create(
  file_path: "/projects/rails_project/app/controllers/assets.js",
  language: "javascript",
  user: test_user,
  code_content: "import '@hotwired/turbo-rails'",
  content: "Make sure you have this in your JS assets"
)

if note1.valid? && note2.valid? && note3.valid?
  puts "Notes Created!"
else
  puts "error in creating notes"
end

category1 = Category.create(
  name: "My First Project",
  category_type: "Project",
  user: test_user
)

category2 = Category.create(
  name: "Javascript Notes",
  category_type: "Language",
  user: test_user
)

if category1.valid? && category2.valid?
  puts "Category Created!"
else
  puts "error in creating categories"
end

category_note1 = CategoryNote.create(
  category: category1,
  note: note1
)

category_note2 = CategoryNote.create(
  category: category2,
  note: note3
)

puts "Finished!"
