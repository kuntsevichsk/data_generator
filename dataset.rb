class DataSet
  attr_accessor :first_name, :last_name, :street, :street_number,
                :apt_number, :city, :postal_code, :phone, :country

  def initialize(array)
    @first_name = array[0]
    @last_name = array[1]
    @street = array[2]
    @street_number = array[3]
    @apt_number = array[4]
    @city = array[5]
    @postal_code = array[6]
    @country = array[7]
    @phone = array[8]
  end

  def to_s
    "#{first_name} #{last_name}; #{street}, #{street_number}, #{apt_number}, #{city}, #{postal_code}, #{country}; #{phone}"
  end
end