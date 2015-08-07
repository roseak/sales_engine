require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository
  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_customer_id(customer_id)
    records.find{|record| record.customer_id == customer_id}
  end

  def find_by_status(status)
    records.find{|record| record.status == status}
  end

  def find_all_by_customer_id(customer_id)
    records.select{|record| record.customer_id == customer_id}
  end

  def find_all_by_status(status)
    records.select{|record| record.status == status}
  end

  def find_transactions_by_invoice_id(transaction_id)
    sales_engine.find_transactions_by_invoice_id(transaction_id)
  end
end
