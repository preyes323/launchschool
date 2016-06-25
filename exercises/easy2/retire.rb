require 'date'

YEAR = Date.today.year

print 'What is your age? '
age = gets.chomp.to_i

print 'At what age would you like to retire? '
retirement_age = gets.chomp.to_i

years_left = retirement_age - age

puts "It's #{YEAR}. You will retire in #{YEAR + years_left}."
puts "You have only #{years_left} years of work to go!"
