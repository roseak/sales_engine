require_relative 'transaction'
require_relative 'repository'

class TransactionRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Transaction.new(row)
    end
  end

end
