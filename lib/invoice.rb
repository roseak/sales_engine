class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id          = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status      = row[:status]
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repository  = repository
  end

  def transactions
    repository.find_transactions_by_invoice_id(id)
  end

  def invoice_items
    repository.find_invoice_items_by_invoice_id(id)
  end

  def items
    invoice_items.map(&:item)
  end

  def customer
    repository.find_customer_by_customer_id(customer_id)
  end

  def merchant
    repository.find_merchant_by_merchant_id(merchant_id)
  end

  def revenue
    invoice_items.map(&:revenue).reduce(0, :+)
  end

  def total_items
    invoice_items.map(&:quantity).reduce(0, :+)
  end

  def successful?
    transactions.any?(&:successful?)
  end

  def on_date?(date)
    Time.parse(created_at).to_date == date
  end

  def charge(payment_data)
    repository.charge(payment_data, id)
  end
end
