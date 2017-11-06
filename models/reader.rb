class Reader
  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  attr_accessor :name, :email, :city, :street, :house
end