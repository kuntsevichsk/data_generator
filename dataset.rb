class DataSet
  attr_accessor :first_name, :last_name, :city, :street, :street_number, :apt_number
  def initialize(array)
    @first_name = array[0]
    @last_name = array[1]
    @city = array[2]
    @street = array[3]
    @street_number = array[4]
    @apt_number = array[5]
  end

  def to_s
    "#{first_name} #{last_name} #{city} #{street} #{street_number} #{apt_number}"
  end
end