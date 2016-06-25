puts 'Enter the first number:'
first_number = gets.chomp.to_i

puts 'Enter the second number:'
second_number = gets.chomp.to_i

operators = %w(+ - * / % **)

operators.each do |operator|
  puts "#{first_number} #{operator} #{second_number}"\
       " = #{first_number.send(operator, second_number)}"
end
