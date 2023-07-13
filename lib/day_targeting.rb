require 'csv'
require 'google/apis/civicinfo_v2'
require 'date'
require_relative 'time_targeting.rb'

def weekday_finder(date)
	Time.strptime(date, "%y/%d/%m %k:%M").wday
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