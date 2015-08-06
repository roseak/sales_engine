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

  def find_by_invoice_id(invoice_id)
    records.find{|record| record.invoice_id == invoice_id}
  end
end
