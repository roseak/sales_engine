require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id          = row[:id].to_i
    @name        = row[:name]
    @description = row[:description]
    @unit_price  = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repository  = repository
  end

  def invoice_items
    repository.find_invoice_items_by_item_id(id)
  end

  def merchant
    repository.find_merchant_by_merchant_id(merchant_id)
  end

  def revenue
    repository.sales_engine.invoice_item_repository.revenue(id)
  end

  def total_items
    repository.sales_engine.invoice_item_repository.total_items(id)
  end

  def best_days(id)
    repository.sales_engine.invoice_item_repository.best_day(id)
  end

  def best_day
    Date.parse(best_days(id).max_by{|k, v| v}[0])
  end
end
