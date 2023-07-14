require 'csv'
require 'google/apis/civicinfo_v2'
require 'date'

def weekday_finder(date)
	Time.strptime(date, "%y/%d/%m %k:%M").wday
end

def highest_repeats_finders(array)
	counter = 0
	day_idx_arr = Array.new

	array.each do |day_idx|
		if array.count(day_idx) > counter
			counter = array.count(day_idx)
		else
			next
		end
	end

	array.each do |day_idx|
		if array.count(day_idx) == counter
			day_idx_arr.push(day_idx)
		end
	end
	return day_idx_arr.uniq
end

def print_peak_registration_days(array)
	days_of_the_week = 
	%w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]

	array = highest_repeats_finders(array)
	if array.count == 1
		puts "The day of the week in which the most registrations occurred is #{days_of_the_week[5]}"
	else
		puts "The days of the week which saw the most registrations are:"
		array.each do |day_idx|
			if day_idx == array.last
				print ", and #{days_of_the_week[day_idx]}"
				print "\n"
			else
				print "#{days_of_the_week[day_idx]}"
			end
		end
	end
end

contents = CSV.open(  
	'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

weekday_array = Array.new
contents.each do |row|
	weekday_array << weekday_finder(row[:regdate])
end

print_peak_registration_days(weekday_array)