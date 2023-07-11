require 'csv'
require 'google/apis/civicinfo_v2'
require 'date'

def hour_finder(date)
	Time.strptime(date, "%y/%d/%m %k:%M").hour
end

def array_element_counter(array)
	counter = 0
	hour = nil

	array.each do |element|
		if array.count(element) > counter
			counter = array.count(element)
			hour = element
		else
			next
		end
	end
	
	return hour
end

puts 'time_targeting.rb running...'

hours_array = Array.new

contents = CSV.open(
  'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

contents.each do |row|
	hours_array << hour_finder(row[:regdate])
end

	puts "The hour of the day in which the most registrations occurs is #{array_element_counter(hours_array)}"	