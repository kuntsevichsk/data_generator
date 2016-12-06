require 'pry'
require 'faker'
require 'yaml'
require_relative 'dataset'
require 'benchmark'

a = []
time = Benchmark.realtime do
  ALLOWED_COUNTRIES = ['us', 'ru', 'by']

  raise ArgumentError, "Should be in #{ALLOWED_COUNTRIES}" unless ALLOWED_COUNTRIES.include? ARGV[0]
  raise ArgumentError, 'Should be a number' unless ARGV[1].to_i
  raise ArgumentError, 'Should be a number' unless ARGV[2].to_i


  all_count = ARGV[1].to_i
  error_count = ARGV[2].to_i
  country = ARGV[0]

  data = YAML.load_file("#{country}/adress.yml")
  men_first_names = YAML.load_file("#{country}/men_first_names.yml")['names']
  women_first_names = YAML.load_file("#{country}/women_first_names.yml")['names']
  all_names = men_first_names + women_first_names
  last_names = YAML.load_file("#{country}/last_names.yml")['names']
  phone_codes = YAML.load_file("#{country}/phone_codes.yml")['codes']

  1.upto(all_count).each do |_idx|
    data.each do |city, postal_codes|
      random_code = postal_codes.keys.sample
      a << DataSet.new([all_names.sample,
                        last_names.sample,
                        city,
                        random_code,
                        postal_codes[random_code].sample,
                        rand(50),
                        rand(50),
                        "+375-#{phone_codes.sample}-#{rand(100..999)}-#{rand(10..99)}-#{rand(10..99)}"])
      break if a.length == all_count
    end
    break if a.length == all_count
  end

end

puts a
puts "#{time*1000} miliseconds for #{a.length} objects"

