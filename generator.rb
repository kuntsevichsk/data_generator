require 'pry'
require 'faker'
require 'yaml'
require_relative 'dataset'
require 'benchmark'

a = []
time = Benchmark.realtime do
  ALLOWED_COUNTRIES = ['us', 'ru', 'by']

  raise ArgumentError, 'Should be a string' unless ALLOWED_COUNTRIES.include? ARGV[0]
  raise ArgumentError, 'Should be a number' unless ARGV[1].to_i
  raise ArgumentError, 'Should be a number' unless ARGV[2].to_i


  all_count = ARGV[1].to_i
  error_count = ARGV[2].to_i
  country = ARGV[0]

  data = YAML.load_file('belarus.yml')
  first_names = YAML.load_file('first_names.yml')['names']
  last_names = YAML.load_file('last_names.yml')['names']

  1.upto(all_count).each do |idx|
    data.each do |city, postal_codes|
      a << DataSet.new([first_names.sample, last_names.sample, city, postal_codes[postal_codes.keys.sample].sample, rand(50), rand(50)])
      break if a.length == all_count
    end
  end

end

puts a
puts "#{time*1000} miliseconds for #{a.length} objects"

