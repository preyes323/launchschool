#! /usr/bin/env ruby
require 'pg'
require 'date'
require 'io/console'
require 'pry'

class ExpenseManager # :nodoc:
  attr_reader :db, :cmd, :param, :memo, :created_on

  def initialize(args)
    @cmd, @param, @memo, @created_on = args
    @db = PG.connect dbname: 'expense_manager'
    setup_schema
    exec_command cmd
  end

  def exec_command(cmd)
    case cmd.to_s.downcase
    when 'list' then list
    when 'add' then add
    when 'clear' then clear
    when 'delete' then delete
    when 'search' then search
    else help
    end
  end

  private

  def list(results = nil)
    results ||= query('SELECT * FROM expenses ORDER BY created_on ASC;')
    display_count results
    display_expenses results if results.ntuples > 0
  end

  def add
    unless param && memo
      puts 'You must provide and amount and a memo'
      return
    end

    @created_on = Date.today unless created_on
    query_string = 'INSERT INTO expenses (amount, memo, created_on) VALUES ($1, $2, $3);'

    query query_string, param, memo, created_on
  end

  def search
    query_string = 'SELECT * FROM expenses WHERE memo ILIKE $1;'
    list(query query_string, "%#{param}%")
  end

  def delete
    query_string = 'SELECT * FROM expenses WHERE id=$1'
    results = query query_string, param

    if results.ntuples > 0
      puts 'The following expenses has been deleted'
      query 'DELETE FROM expenses WHERE id=$1', param
      list results
    else
      puts "There is no expense with the id #{param}"
    end
  end

  def clear
    puts 'This will remove all expenses. Are you sure? (y/n)'
    answer = $stdin.getch
    query 'DELETE FROM expenses';
    puts 'All expenses have been deleted'
  end

  def help
    puts <<~EOF
         An expense recording system

         Commands:

         add AMOUNT MEMO [DATE] - record a new expense
         clear - delete all expenses
         list - list all expenses
         delete NUMBER - remove expense with id NUMBER
         search QUERY - list expenses with a matching memo field
         EOF
  end

  def display_count(results)
    count = results.ntuples
    msg = count > 0 ? "There are #{count} expenses." : 'There are no expenses.'
    puts msg
  end

  def display_expenses(results)
    results.each do |row|
      columns = [row['id'].rjust(3),
                 row['created_on'].rjust(10),
                 row['amount'].rjust(12),
                 row['memo']]

      puts columns.join(' | ')
    end

    puts "-" * 50
    amount_sum = results.field_values("amount").map(&:to_f).inject(:+)
    puts "Total #{amount_sum.round(2).to_s.rjust(25)}"
  end

  def query(query_string, *args)
    args.length > 0 ? db.exec_params(query_string, args) : db.exec(query_string)
  end

  def setup_schema
    result = db.exec <<~SQL
      SELECT COUNT(*) FROM information_schema.tables
      WHERE table_schema = 'public' AND table_name = 'expenses';
    SQL

    if result[0]["count"] == "0"
      db.exec <<~SQL
        CREATE TABLE expenses (
          id serial PRIMARY KEY,
          amount numeric(6,2) NOT NULL CHECK (amount >= 0.01),
          memo text NOT NULL,
          created_on date NOT NULL
        );
      SQL
    end
  end
end

manager = ExpenseManager.new ARGV
