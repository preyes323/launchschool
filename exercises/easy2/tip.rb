print 'What is the bill? '
bill = gets.chomp.to_f

print 'What is the tip percentage? '
tip_percent = gets.chomp.to_f

tip_value = bill * tip_percent
total = bill + tip_value

puts "The the tip is $#{tip_value}"
puts "The total is $#{total}"
