require './models/library'
gem 'faker', :git => 'git://github.com/stympy/faker.git', :branch => 'master'
require 'faker'

BOOKS = [Book.new(Faker::Book.title, Faker::Book.author), Book.new(Faker::Book.title, Faker::Book.author)]
@my_lib = Library.new(BOOKS, nil, nil, nil)
@my_lib.add_book("The Hobbit", "J. R. R. Tolkien")
5.times do @my_lib.add_book(Faker::Book.title, Faker::Book.author) end
puts @my_lib.find_book_by_title("The Hobbit")
@my_lib.add_reader(Faker::Name.name, Faker::Internet.email, Faker::Address.city, Faker::Address.street_name, Faker::Address.building_number)
@my_lib.add_reader("The Same Reader", "The Same Email", "The Same City", "The Same Steet", "The Same Building")
@my_lib.add_reader("The Same Reader", "The Same Email", "The Same City", "The Same Steet", "The Same Building")
@my_lib.order_the_book("The Hobbit", "The Same Reader")
puts @my_lib.books
puts @my_lib.readers
puts @my_lib.orders
@my_lib.three_most_popular_books
@my_lib.what_is_the_most_popular_book