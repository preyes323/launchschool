module ExpenseTracker # :nodoc:
  RecordResult = Struct.new :success?, :expense_id, :error_message

  class Ledger
    def record(expense)
    end
  end
end
