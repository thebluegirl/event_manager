require 'csv'
require 'google/apis/civicinfo_v2'
require 'date'

def hour_finder(date)
	Time.strptime(date, "%y/%d/%m %k:%M").hour
end

def repeat_hour_finder(array)
	counter = 0
	hour_arr = Array.new

	array.each do |hour|
		if array.count(hour) > counter
			counter = array.count(hour)
		else
			next
		end
	end

	array.each do |hour|
		if array.count(hour) == counter
			hour_arr.push(hour)
		end
	end
	
	return hour_arr
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

puts "The hours of the day in which the most registrations occured are #{repeat_hour_finder(hours_array)}"	