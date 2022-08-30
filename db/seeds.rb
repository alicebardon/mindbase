# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "starting seeds"
CategoryNote.destroy_all
User.find(1234).destory if User.find(1234).present?
Note.destroy_all
Category.destroy_all

test_user = User.create(id: 1234, email: "user@test.com", password: "1234567", first_name: "test")

puts "Creating notes..."

note1 = {
  file_path: "/projects/rails_project/app/controllers/page_controller.rb",
  language: "ruby",
  user_id: test_user,
  code_content: "class PagesController < ApplicationController",
  content: "This is how you intert from a parent class"
}

if Note.create(note1)
  puts Note.all
else
  puts "error in creating notes"
end

#[dishoom, pizza_east].each do |attributes|
#  restaurant = Restaurant.create!(attributes)
#  puts "Created #{restaurant.name}"
#end


#puts "Finished!"
