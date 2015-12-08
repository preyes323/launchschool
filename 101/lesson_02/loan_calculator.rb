# -----------------------------------
# LOAN CALCULATOR APP
# loan_caluclator.rb
#
# Given the value for loan amount, APR, and loan duration the app will
# produce a table that presents the payment plan to the loaner
# -----------------------------------

require 'colorize'
require 'io/console'

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
    if numeric?(amount)
      return Float(amount) if amount.length <= 15
      msg('Can not compute for loan amount with digits > 15', color: :red)
    end
  end
end

def monthly_percentage_rate_input
  loop do
    msg('Input annual percentage rate: ', new_line: false)
    apr = gets.chomp
    return (Float(apr) / 100 / 12).round(4) if numeric?(apr)
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

def compute_monthly_payment(loan_params)
  amt = loan_params[:amount]
  rate = loan_params[:rate]
  n = loan_params[:duration]
  (amt * (rate * (1 + rate)**n) / ((1 + rate)**n - 1)).round(2)
end

def compute_monthly_balance(month, loan_params)
  amt = loan_params[:amount]
  rate = loan_params[:rate]
  n = loan_params[:duration]
  (amt * ((1 + rate)**n - (1 + rate)**month) / ((1 + rate)**n - 1)).round(2)
end

def compute_payments(loan_params)
  balance, principal, interest = [[], [], []]
  amount = loan_params[:amount]
  duration = loan_params[:duration]
  rate = loan_params[:rate]
  monthly_payment = compute_monthly_payment(loan_params)
  duration.times do |month|
    interest << ((balance[-1] || amount) * rate).round(2)
    balance << compute_monthly_balance(month + 1, loan_params)
    principal << (monthly_payment - interest[-1]).round(2)
  end
  { monthly_payment: monthly_payment, principal: principal,
    interest: interest, balance: balance }
end

def narrow_screen(payments)
  msg(' MONTHLY PAYMENT SCHEDULE '.center(40, '-'), color: :blue)
  payments[:balance].each_with_index do |_, month|
    msg(" Month #{month + 1} ".center(40, '.'), color: :blue)
    msg(add_padding('Payment:', 15), new_line: false)
    msg("#{payments[:monthly_payment]}")
    msg(add_padding('Principal:', 15), new_line: false)
    msg("#{payments[:principal][month]}")
    msg(add_padding('Interest:', 15), new_line: false)
    msg("#{payments[:interest][month]}")
    msg(add_padding('Balance:', 15), new_line: false)
    msg("#{payments[:balance][month]}")
  end
end

def wide_screen(payments)
  msg(' MONTHLY PAYMENT SCHEDULE '.center(80, '-'), color: :blue)
  msg("|#{'Month'.center(10, ' ')}|", new_line: false)
  msg("#{'Payment'.center(16, ' ')}|", new_line: false)
  msg("#{'Principal'.center(16, ' ')}|", new_line: false)
  msg("#{'Interest'.center(16, ' ')}|", new_line: false)
  msg("#{'Balance'.center(16, ' ')}|")
  payments[:balance].each_with_index do |_, month|
    msg("|#{(month + 1).to_s.center(10, ' ')}|", new_line: false)
    msg("#{payments[:monthly_payment].to_s.center(16, ' ')}|", new_line: false)
    msg("#{payments[:principal][month].to_s.center(16, ' ')}|", new_line: false)
    msg("#{payments[:interest][month].to_s.center(16, ' ')}|", new_line: false)
    msg("#{payments[:balance][month].to_s.center(16, ' ')}|")
  end
  msg('-' * 80, color: :blue)
end

def display_schedule(payments)
  _, cols = $stdin.winsize
  cols >= 80 ? wide_screen(payments) : narrow_screen(payments)
end

begin
  system 'clear'
  msg('The result of the app is best viewed ', color: :green, new_line: false)
  msg('with a screen width of 80.', color: :green)
  sleep(3)
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
  payments = compute_payments(amount:   loan_amount,
                              rate:     monthly_percentage_rate,
                              duration: loan_duration_months)
  display_schedule(payments)
end

