class Order
  def initialize(book, reader, date=Time.now.strftime("%Y-%d-%m"))
    @book = book
    @reader = reader
    @date = date
  end

  attr_accessor :book, :reader, :date
end