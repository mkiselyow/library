require './models/book'
require './models/order'
require './models/reader'
require './models/author'

class Library
  BOOKS   = 'books.txt'
  ORDERS  = 'orders.txt'
  READERS = 'readers.txt'
  AUTHORS = 'authors.txt'

  attr_accessor :books, :orders, :readers, :authors

  def initialize(books=[], orders=[], readers=[], authors=[])
    @books   = books
    @orders  = orders
    @readers = readers
    @authors = authors
  end

  def load_info
    load_entities
  end

  def add_book(book)
    @books << book if find_book_by_title(book.title) == nil
    File.open(BOOKS, 'w'){|f| f.write(Marshal.dump(@books)) }
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
      File.open(ORDERS, "w"){|f| f.write(Marshal.dump(@orders)) }
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
      File.open(READERS, "w"){|f| f.write(Marshal.dump(@readers)) }
    else
      puts "This Reader already exists"
    end
  end

  def three_most_popular_books
    hsh = {}
    orders.each do |order| 
      hsh[order.book]||=0
      hsh[order.book] += 1
    end
    @top_book         = hsh.max_by{|k,v| v}[0]
    @top_three_books = hsh.max_by(3){|k,v| v}.to_h.keys
  end

  def random_book_title
    books.sample.title
  end

  def random_reader_name
    readers.sample.name
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    top_books = []
    top_books << three_most_popular_books[0]
    top_books << three_most_popular_books[1]
    top_books << three_most_popular_books[2]
    readers_who_read_popular_books = []
    top_books.each do |book|
      find_orders_by_book_title(book.title).each {|order| readers_who_read_popular_books << order.reader}
    end
    readers_who_read_popular_books
  end

  def what_is_the_most_popular_book
    three_most_popular_books
    @top_book
  end

  private

  def load_entities
    begin
      @books   = Marshal.load(File.read(BOOKS))
      @orders  = Marshal.load(File.read(ORDERS))
      @readers = Marshal.load(File.read(READERS))
      @authors = Marshal.load(File.read(AUTHORS))
    rescue ArgumentError => e
      puts "====================ArgumentError===================="
      puts "#{e}. You have empty files with data"
      puts "====================ArgumentError===================="
    end
  end
end