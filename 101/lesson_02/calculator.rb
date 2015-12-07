# -----------------------------------
# Caluclator APP
# This calculator app performs basic arithmetic calculation (+, -, /, *) on a
# series of numbers.  The calculator recognizes the pressing of the 'enter'
# key to mean get the value for the series.
# Current calculator app does not recognize MDAS operation. It will apply the
# operation in a sequential manner. Any error in input will prompt the user
# to begin from the start again.
#
# EXAMPLE
# 5 + 2 * 3 - 5 (enter)
# 16 (non-MDAS) ; 6 (MDAS)
# -----------------------------------

require 'pry'
require 'colorize'

def msg(msg, color = :default, new_line = true)
  if new_line
    puts msg.colorize(color)
  else
    print msg.colorize(color)
  end
end

def find_operator_index(number_series)
  if number_series[0] == '-'
    number_series.index(%r{[-+*/]}, 1)
  else
    number_series.index(%r{[-+*/]})
  end
end

def parse_series(number_series)
  numbers = []
  operators = []
  number_series.gsub!(%r{[\s,]}, '')
  until number_series.empty?
    operator_index = find_operator_index(number_series)
    if operator_index
      numbers << number_series.slice!(0..operator_index - 1)
    else
      numbers << number_series
      number_series = ''
    end
    operators << number_series.slice!(0) unless number_series.empty?
  end
  return numbers, operators
end

def convert_to_numbers(numbers)
  numbers.map { |number| numeric?(number) ? Float(number) : (return false) }
end

def numeric?(number)
  !!Float(number) rescue false
end

def perform_operations(numbers, operators)
  result = numbers.shift
  until numbers.empty?
    case operators.shift
    when '+' then result += numbers.shift
    when '-' then result -= numbers.shift
    when '/' then result /= numbers.shift
    when '*' then result *= numbers.shift
    end
  end
  result.round(2)
end

def get_series
  series = gets.chomp
  series = '0' if series.empty?
end

loop do
  system 'clear'
  msg('Welcome to the calculator APP', :blue)
  msg('NOTE: MDAS is not followed. Operation is applied in sequence', :red)
  msg('=============================', :light_black)
  msg('=============================', :light_black)
  msg('Enter the series of numbers')
  msg('ex: 5 + 2 * 3 - 5 (enter press)')
  msg('=> ', :blue, false)
  number_series = get_series
  msg(number_series, :green)
  numbers, operators = parse_series(number_series)
  unless numbers = convert_to_numbers(numbers)
    msg('Some numbers where not valid', :red)
    msg('Please check your input!', :red)
    break
  end
  result = perform_operations(numbers, operators)
  msg("result = #{result}", :green)
  msg('Peform another operation (y/n)? ', :default, false)
  perform_another = gets.chomp
  break unless perform_another.downcase == 'y'
end
