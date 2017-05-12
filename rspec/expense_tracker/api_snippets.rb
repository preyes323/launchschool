class API < Sinatra::Base # :nodoc:
  def initialize
    @ledger = Ledger.new
    super()
  end
end
