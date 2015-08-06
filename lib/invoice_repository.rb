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
      Invoice.new(row)
    end
  end

  def find_by_customer_id(customer_id)
    records.find{|record| record.customer_id == customer_id}
  end

  def find_by_status(status)
    records.find{|record| record.status == status}
  end

end
