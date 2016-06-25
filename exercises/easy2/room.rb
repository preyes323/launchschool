METER_TO_FEET = 10.7639

puts 'Enter the length of the room in meters:'
length = gets.chomp.to_i

puts 'Enter the width of the room in meters:'
width = gets.chomp.to_i

area_meters = length * width
area_feet = area_meters * METER_TO_FEET

puts "The area of the room is #{format('%#.2f', area_meters)} " \
     "square meters (#{format('%#.2f', area_feet)} square feet)."
