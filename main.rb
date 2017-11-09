require './models/library'
require 'faker'

@my_lib = Library.new
@my_lib.load_info

# BOOKS = [Book.new(Faker::Book.title, Faker::Book.author), Book.new(Faker::Book.title, Faker::Book.author)]
# @my_lib = Library.new(BOOKS, nil, nil, nil)
new_book = Book.new("The Hobbit", "J. R. R. Tolkien")
@my_lib.add_book(new_book)
5.times do 
  new_book = Book.new(Faker::Book.title, Faker::Book.author)
  @my_lib.add_book(new_book)
end
@my_lib.print_books_all
# puts @my_lib.find_book_by_title("The Hobbit")
@my_lib.add_reader(Faker::Name.name, Faker::Internet.email, Faker::Address.city, Faker::Address.street_name, Faker::Address.building_number)
@my_lib.add_reader("The Same Reader", "The Same Email", "The Same City", "The Same Steet", "The Same Building")
@my_lib.find_reader_by_name("The Same Reader")
@my_lib.order_the_book("The Hobbit","The Same Reader")
p "#{@my_lib.three_most_popular_books} are three the most ordered books"
p "#{@my_lib.what_is_the_most_popular_book} is the most popular book"
p "#{@my_lib.how_many_people_ordered_one_of_the_three_most_popular_books.count }  readers read popular books"
2.times { @my_lib.order_the_book(@my_lib.random_book_title, @my_lib.random_reader_name) }

# @my_lib.add_reader("The Same Reader", "The Same Email", "The Same City", "The Same Steet", "The Same Building")
# @my_lib.order_the_book("The Hobbit", "The Same Reader")
# puts @my_lib.books
# puts @my_lib.readers
# puts @my_lib.orders
# @my_lib.three_most_popular_books
# @my_lib.what_is_the_most_popular_book