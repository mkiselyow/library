require './models/book'
require './models/order'
require './models/reader'
require './models/author'

class Library
  def initialize(books, orders, readers, authors)
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
    File.open("library.txt", "a+") do |f|
      f.write("#{File.path("books.txt")} - books\n")
      f.write("#{File.path("readers.txt")} - readers\n")
      f.write("#{File.path("orders.txt")} - orders\n")
    end
  end
  attr_accessor :books, :orders, :readers, :authors
  #to do: @books << File.open("books.txt", "a+")
  #to do: orders+readers+books methods to one method
  #to do: txt to xls table

  def add_book(title, author)
    new_book = Book.new(title, author)
    File.open("books.txt", "a+"){|f| f.write("#{new_book.title} | by #{new_book.author} | Added to library #{Time.now} \n")}
    puts "======= New book have been added ======="
  end

  def books
    puts "======= ALL BOOKS ======="
    books = File.open("books.txt", "a+")
    books.each_line do |line|
      puts line
    end
    books.close
  end

  def orders
    puts "======= ALL orders ======="
    counter = 1
    orders = File.open("orders.txt", "a+")
    orders.each_line do |line|
      puts "#{counter}: #{line}"
      counter = counter + 1
    end
    orders.close
  end

  def readers
    puts "======= ALL readers ======="
    readers = File.open("readers.txt", "a+")
    readers.each_line do |line|
      puts line
    end
    readers.close
  end

  def find_book_by_title(search)
    puts "======= Search Book ======="
    @result = []
    File.foreach("books.txt"){|x| @result << x if x.match(search)}
    @result
  end

  def order_the_book(book, reader)
    order_book = find_book_by_title(book).take(1).join.chomp
    order_reader = find_reader(reader).take(1).join.chomp
    if order_book && order_reader
      new_order = Order.new(order_book, order_reader)
      File.open("orders.txt", "a+"){|f| f.write("#{order_book} | #{order_reader} | #{Time.now.strftime("%Y-%d-%m")}\n")}
      puts "======= New Order have been added ======="
    else
      puts "======= No such Book or Reader =========="
    end
  end

  def find_reader(search)
    @result = []
    File.foreach("readers.txt"){|x| @result << x if x.match(search)}
    @result
  end

  def add_reader(name, email, city, street, house)
    if find_reader(name).empty? != true
      reader = Reader.new(name, email, city, street, house)
      File.open("readers.txt", "a+"){|f| f.write("#{reader.name} | #{reader.email} | #{reader.city} | #{reader.street} | #{reader.house}\n")}
      puts "======= New Reader have been added ======="
    else
      puts "This Reader already exists"
    end
  end

  def three_most_popular_books
    puts "======= Three Most Popular Books ======="
    most_popular = []
    orders = File.open("orders.txt", "a+")
    orders.each_line do |line|
      most_popular << line.split(" | ")[0]
    end
    popular_hash = Hash[most_popular.uniq.map { |x| [x, most_popular.count(x)] }]
    @three_most_freq = most_popular.sort_by { |x| popular_hash[x] }.last(3)
    @most_freq = most_popular.sort_by { |x| popular_hash[x] }.last
    orders.close
    puts @three_most_freq
  end


  def how_many_people_ordered_one_of_the_three_most_popular_books
  end

  def what_is_the_most_popular_book
    puts "======= The Most Popular Book ======="
    puts @most_freq
  end
end