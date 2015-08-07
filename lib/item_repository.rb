require_relative 'item'
require_relative 'repository'

class ItemRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_description(description)
    if description
      records.find do |record|
        return if !record.description
        record.description.upcase == description.upcase
      end
    else
      nil
    end
  end

  def find_all_by_description(description)
    records.select{|record| record.description == description}
  end

  def find_invoice_items_by_item_id(item_id)
    sales_engine.find_invoice_items_by_item_id(item_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end
end
