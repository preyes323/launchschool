# -----------------------------------
# LOAN CALCULATOR APP
# loan_caluclator.rb
#
# Given the value for loan amount, APR, and loan duration the app will
# produce a table that presents the payment plan to the loaner
# -----------------------------------

require 'colorize'

def msg(msg, color: :default, new_line: true)
  if new_line
    puts msg.colorize(color)
  else
    print msg.colorize(color)
  end
end

def numeric?(number)
  !!Float(number) rescue false
end

def loan_amount_input
  loop do
    msg('Input loan amount: ', new_line: false)
    amount = gets.chomp
    return Float(amount) if numeric?(amount)
  end
end

def monthly_percentage_rate_input
  loop do
    msg('Input annual percentage rate: ', new_line: false)
    apr = gets.chomp
    return (Float(apr)/100/12).round(2) if numeric?(apr)
  end
end

def loan_duration_months_input
  loop do
    msg('Input loan duration (in years): ', new_line: false)
    duration = gets.chomp
    return Integer(duration) * 12 if numeric?(duration)
  end
end

def add_padding(text, total_padding)
  text + ' ' * (total_padding - text.length)
end

begin
  system 'clear'
  msg('LOAN CALCULATOR APP', color: :blue)  
  msg('---')
  msg('This app produces your monthly payment schedule given the following:')
  msg('Loan Amount -  ex: $ 10,000.00)', color: :green)
  msg('Annual Percentage Rate (APR) - ex: 12 %', color: :green)
  msg('Loan Duraation (in years) - ex: 3 years', color: :green)
  msg('---')
  msg('---')
  loan_amount = loan_amount_input
  monthly_percentage_rate = monthly_percentage_rate_input
  loan_duration_months = loan_duration_months_input
  system 'clear'
  msg('LOAN PARAMETERS', color: :blue)
  msg("Loan Amount:       $#{loan_amount}")
  msg("Monthly % Rate:    #{monthly_percentage_rate}")
  msg("Duration (months): #{loan_duration_months}")
  # monthly_payment = compute_payment(loan_amount,
  #                                   monthly_percentage_rate,
  #                                   loan_duration_months)  
  msg(' MONTHLY PAYMENT SCHEDULE '.center(25, '-'), color: :blue)
  loan_duration_months.times do |month|
    msg(" Month #{month + 1} ".center(25, '.'))
    msg(add_padding('Payment:', 12))
    msg(add_padding('Balance:', 12))
    msg(add_padding('Principal:', 12))
    msg(add_padding('Interest:', 12))    
  end
end



