class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository = nil)
    @id         = row[:id].to_i
    @name       = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def items
    repository.find_items_by_merchant_id(id)
  end

  def invoices
    repository.find_invoices_by_merchant_id(id)
  end

  def revenue(date = nil)
    successful_invoices_on_date(date).map(&:revenue).reduce(0, :+)
  end

  def total_items
    invoices.map(&:total_items).reduce(0, :+)
  end

  def favorite_customer
    successful_invoices = invoices.select(&:successful?)
    totaled_invoices = successful_invoices.group_by(&:customer_id)
    favorite_customer_id = totaled_invoices.max_by {|k, v| v.count}
    repository.find_customer_by_customer_id(favorite_customer_id[0])
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.select do |invoice|
      invoice.successful? == false
    end
    deadbeat_customers = pending_invoices.map(&:customer_id)
  end

  private

  def successful_invoices_on_date(date)
    result = invoices.select(&:successful?)
    if date
      result.select! { |invoice| invoice.on_date?(date) }
    end
    result
  end
end
