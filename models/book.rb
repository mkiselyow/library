class Book
  attr_accessor :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    super
    "#{self.title} | written by | #{self.author}"
  end
end