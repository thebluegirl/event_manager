require 'csv'
require 'google/apis/civicinfo_v2'

def clean_phone_numbers(number)
	number = number.gsub(/\D/, "")

	if number.length == 10
		return number
	elsif number.length < 10 || number.length > 11
		return "Invalid number provided"
	elsif number.length == 11 && number[0] == "1"
		return number[1..-1]
	end

end

puts 'clean_numbers.rb running...'

contents = CSV.open(
	'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

contents.each do |row|
  name = "#{row[:first_name]} #{row[:last_name]}"
	phone_number = clean_phone_numbers(row[:homephone])
	
	puts "#{name}: #{phone_number}"
end