class DataSet
  attr_accessor :first_name, :last_name, :city, :postal_code,
                :street, :street_number, :apt_number, :phone

  def initialize(array)
    @first_name = array[0]
    @last_name = array[1]
    @city = array[2]
    @postal_code = array[3]
    @street = array[4]
    @street_number = array[5]
    @apt_number = array[6]
    @phone = array[7]
  end

  def to_s
    "#{first_name} #{last_name}; #{city} #{postal_code} ул. #{street} #{street_number}, кв. #{apt_number}; #{phone}"
  end
end