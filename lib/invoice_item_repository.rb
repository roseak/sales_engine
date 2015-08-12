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

  def successful_invoice_items(item_id)
    find_all_by_item_id(item_id).select(&:successful?)
  end

  def revenue(item_id)
    successful_invoice_items(item_id).map(&:revenue).reduce(0, :+)
  end

  def total_items(item_id)
    successful_invoice_items(item_id).map(&:quantity).reduce(0, :+)
  end

  def success_by_date(item_id)
    successful_invoice_items(item_id).group_by do |invoice_item|
      invoice_item.invoice.created_at
    end
  end


  def best_day(item_id)
    success_by_date(item_id).map{|k, v| [k,v.map(&:revenue).reduce(0, :+)]}.to_h
  end

  def create_invoice_items(items, new_invoice_id)
    items.map do |item|
      new_invoice_item = InvoiceItem.new({id: next_id,
                item_id: item.id,
                invoice_id: new_invoice_id,
                quantity: 1,
                unit_price: item.unit_price,
                created_at: Time.new.strftime("%c %d, %Y"),
                updated_at: Time.new.strftime("%c %d, %Y")},
                self)
      records << new_invoice_item
    end
  end

  def next_id
    if records.last.nil?
      1
    else
      records.last.id.next
    end
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end
end
