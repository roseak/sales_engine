require_relative 'invoice_item'
require_relative 'repository'

class InvoiceItemRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      InvoiceItem.new(row)
    end
  end

  def find_by_item_id(item_id)
    records.find{|record| record.item_id == item_id}
  end

  def find_by_quantity(quantity)
    records.find{|record| record.quantity == quantity}
  end

  def find_all_by_item_id(item_id)
    records.select{|record| record.item_id == item_id}
  end

  def find_all_by_quantity(quantity)
    records.select{|record| record.quantity == quantity}
  end

end
