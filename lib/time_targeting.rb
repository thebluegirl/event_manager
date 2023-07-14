require 'csv'
require 'google/apis/civicinfo_v2'
require 'date'

def hour_finder(date)
	Time.strptime(date, "%y/%d/%m %k:%M").hour
end

def highest_repeats_finders(array)
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
	
	return hour_arr.uniq
end

def print_peak_registration_hours(array)
	if array.count == 1
		print "The hour of the day in which the most registrations occurred is: #{hour}:00"
	else
		puts "The hours of the day in which the most registrations occurred are:"
		array.each do |hour|
			if hour == array.last
				print "and #{hour}:00"
			else
				print "#{hour}:00, "
			end
		end
		print "\n"
	end
end

hours_array = Array.new

contents = CSV.open(
  'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

contents.each do |row|
	hours_array << hour_finder(row[:regdate])
end

print_peak_registration_hours(highest_repeats_finders(hours_array))