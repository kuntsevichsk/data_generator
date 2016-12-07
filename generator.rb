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

  data = YAML.load_file("#{country}/address.yml")
  all_names = YAML.load_file("#{country}/all_names.yml")['names']
  last_names = YAML.load_file("#{country}/last_names.yml")['names']
  phone_codes = YAML.load_file("#{country}/phone_codes.yml")['codes']

  def phone(country)
    if country=='us'
      return "+1-#{rand(200..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
    if country=="ru"
      return "+7-#{phone_codes.sample}-#{rand(100..999)}-#{rand(10..99)}-#{rand(10..99)}"
    if country=='by'
      return "+375-#{phone_codes.sample}-#{rand(100..999)}-#{rand(10..99)}-#{rand(10..99)}"

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
                        phone(country)])
      break if a.length == all_count
    end
    break if a.length == all_count
  end

end

puts a
puts "#{time*1000} miliseconds for #{a.length} objects"

