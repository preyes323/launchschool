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


begin
  system 'clear'
  msg('LOAN CALCULATOR APP', color: :blue)
  msg('---')
  msg('This app produces your monthly payment schedule given the following:')
  msg('Loan Amount -  ex: $ 10,000.00)', color: :green)
  msg('Annual Percentage Rate (APR) - ex: 12 %', color: :green)
  msg('Loan Duraation (in years) - ex: 3 years', color: :green)
end



