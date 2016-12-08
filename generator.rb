require 'pry'
require 'faker'
require 'yaml'
require_relative 'dataset'
require 'benchmark'

a = []
time = Benchmark.realtime do
  ALLOWED_COUNTRIES = ['us', 'ru', 'by']
  COUNTRY = { 'us' => 'USA', 'ru' => 'Россия', 'by' => 'Беларусь' }

  raise ArgumentError, "Should be in #{ALLOWED_COUNTRIES}" unless ALLOWED_COUNTRIES.include? ARGV[0]
  raise ArgumentError, 'Should be a number' unless ARGV[1].to_i
  raise ArgumentError, 'Should be a number' unless ARGV[2].to_i


  all_count = ARGV[1].to_i
  error_per_object_count = ARGV[2].to_f
  country = ARGV[0]
  error_objects_to_generate = (all_count * error_per_object_count).round

  data = YAML.load_file("#{country}/address.yml")
  all_names = YAML.load_file("#{country}/all_names.yml")['names']
  last_names = YAML.load_file("#{country}/last_names.yml")['names']
  phone_codes = YAML.load_file("#{country}/phone_codes.yml")['codes']

  def phone(country, phone_codes)
    if country == 'us'
      return "+1-#{rand(200..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
    elsif country == 'ru'
      return "+7-#{phone_codes.sample}-#{rand(100..999)}-#{rand(10..99)}-#{rand(10..99)}"
    elsif country == 'by'
      return "+375-#{phone_codes.sample}-#{rand(100..999)}-#{rand(10..99)}-#{rand(10..99)}"
    end
  end


  def generate_error(x)
    string_size = x.size
    rand_symbol_num = rand(1..(string_size - 1))

    case rand_symbol_num % 3
      when 0
        x.slice!(rand_symbol_num)
      when 1
        sym_was = x[rand_symbol_num]
        x[rand_symbol_num] = x[rand_symbol_num - 1]
        x[rand_symbol_num - 1] = sym_was
      when 2
        x = x.insert(rand_symbol_num, x[rand(string_size - 1)])
    end
    x
  end

    1.upto(all_count).each do |_idx|
      data.each do |city, postal_codes|
        random_code = postal_codes.keys.sample
        d = DataSet.new([all_names.sample,
                         last_names.sample,
                         postal_codes[random_code].sample,
                         rand(50),
                         rand(50),
                         city,
                         random_code,
                         COUNTRY[country],
                         phone(country, phone_codes)])


        if error_per_object_count > 1
          1.upto(error_per_object_count) do |_index|
            d.full_string = generate_error(d.full_string)
          end
        elsif error_objects_to_generate != 0
          error_objects_to_generate -= 1
          d.full_string = generate_error(d.full_string)
        end

        a << d
        break if a.length == all_count
      end
      break if a.length == all_count
    end
  end

puts a
puts "#{time*1000} miliseconds for #{a.length} objects"

