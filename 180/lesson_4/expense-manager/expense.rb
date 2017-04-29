#! /usr/bin/env ruby
require 'pg'
require 'pry'

class ExpenseManager # :nodoc:
  attr_reader :db, :cmd, :amt, :memo, :created_on

  def initialize(args)
    @cmd, @amt, @memo, @created_on = args
    @db = PG.connect dbname: 'expense_manager'
    exec_command cmd
  end

  def exec_command(cmd)

  end

  private

  def list
    results = query('SELECT * FROM expenses ORDER BY created_on ASC;')
    results.each do |row|
      columns = [row['id'].rjust(3),
                 row['created_on'].rjust(10),
                 row['amount'].rjust(12),
                 row['memo']]

      puts columns.join(' | ')
    end
  end

  def query(query_string)
    db.exec query_string
  end
end

manager = ExpenseManager.new ARGV
