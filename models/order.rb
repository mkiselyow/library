class Order
  attr_accessor :book, :reader, :date
  def initialize(book, reader, date=Time.now.strftime("%Y-%d-%m"))
    @book = book
    @reader = reader
    @date = date
  end
end