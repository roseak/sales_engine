require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @item_id    = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity   = row[:quantity].to_i
    @unit_price = BigDecimal.new(row[:unit_price])/100
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def invoice
    repository.find_invoice_by_invoice_id(invoice_id)
  end

  def item
    repository.find_item_by_item_id(item_id)
  end

  def revenue
    quantity * unit_price
  end

  def successful?
    invoice.successful?
  end
end
