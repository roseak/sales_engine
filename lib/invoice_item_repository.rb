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
      InvoiceItem.new(row, self)
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

  def find_invoice_by_invoice_id(invoice_id)
    sales_engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    sales_engine.find_item_by_item_id(item_id)
  end

  def revenue(item_id)
    find_all_by_item_id(item_id).select(&:successful?).map(&:revenue).reduce(0, :+)
  end

  def total_items(item_id)
    find_all_by_item_id(item_id).select(&:successful?).map(&:quantity).reduce(0, :+)
  end

  def best_day(item_id)
    sorted_invoice_items = find_all_by_item_id(item_id).select(&:successful?).group_by{|invoice_item| invoice_item.invoice.created_at}
    result = sorted_invoice_items.map {|k, v| [k,v.map(&:revenue).reduce(0, :+) ] }.to_h
  end
  #
  # some hash.map do |k,v|
  #   [k,v.reduce(:+)]
  # end.to_h

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end
end
