require './models/book'
require './models/order'
require './models/reader'
require './models/author'

class Library
  attr_accessor :books, :orders, :readers, :authors
  def initialize(books=nil, orders=nil, readers=nil, authors=nil)
    @books   = []
    @orders  = []
    @readers = []
    @authors = []
    begin
      @books   = Marshal.load(File.read('books.txt'))   if !Marshal.load(File.read('books.txt')).empty?
      @orders  = Marshal.load(File.read('orders.txt'))  if !Marshal.load(File.read('orders.txt')).empty?
      @readers = Marshal.load(File.read('readers.txt')) if !Marshal.load(File.read('readers.txt')).empty?
      @authors = Marshal.load(File.read('authors.txt')) if !Marshal.load(File.read('authors.txt')).empty?
    rescue(ArgumentError) 
    end
      #Marshal.load(File.read('library.txt'))
      #File.open('library.txt', 'w') {|f| f.write(Marshal.dump(m)) }
  end
  #to do: @books << File.open("books.txt", "a+")
  #to do: orders+readers+books methods to one method
  #to do: txt to xls table

  def add_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book if find_book_by_title(title) == nil
    File.open("books.txt", "w"){|f| f.write(Marshal.dump(@books)) }
  end

  def print_books_all
    @books.each_with_index {|book, index| p "#{index} | #{book}"}; nil
  end

  def print_search_result
    books.select {|book| book.title == book_title }.join
  end

  def find_book_by_title(book_title)
    books.select {|book| book.title == book_title }.first
  end

  def find_orders_by_book_title(book_title)
    orders.select {|order| order.book.title == book_title }
  end

  def order_the_book(book_title, reader_name)
    order_book   = find_book_by_title(book_title)
    order_reader = find_reader_by_name(reader_name)
    if order_book && order_reader
      new_order = Order.new(order_book, order_reader)
      @orders << new_order
      File.open("orders.txt", "w"){|f| f.write(Marshal.dump(@orders)) }
    else
      puts "======= No such Book or Reader =========="
    end
  end

  def find_reader_by_name(reader_name)
    readers.select {|reader| reader.name == reader_name }.first
  end

  def add_reader(name, email, city, street, house)
    if !find_reader_by_name(name)
      new_reader = Reader.new(name, email, city, street, house)
      @readers << new_reader
      File.open("readers.txt", "w"){|f| f.write(Marshal.dump(@readers)) }
    else
      puts "This Reader already exists"
    end
  end

  def three_most_popular_books
    hsh = {}
    orders.each {|order| hsh[order.book.title]||=0; hsh[order.book.title] += 1}
    hsh.max(3)
  end

  def random_book_name
    books.each {|book| @books_titles_arr ||= []; @books_titles_arr << book.title}.shuffle.first.title
  end

  def random_reader_name
    readers.each {|reader| @readers_names_arr ||= []; @readers_names_arr << reader.name}.shuffle.first.name
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    top_books_titles = []
    top_books_titles << three_most_popular_books[0][0]
    top_books_titles << three_most_popular_books[1][0]
    top_books_titles << three_most_popular_books[2][0]
    top_books_titles.each do |book_title|
      find_orders_by_book_title(book_title).each {|order| arrr << order.reader.name}
    end
  end

  def what_is_the_most_popular_book
    three_most_popular_books
    hsh.max
  end
end