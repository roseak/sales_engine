class Merchant
  attr_reader :id,          # => :id
              :name,        # => :name
              :created_at,  # => :created_at
              :updated_at,  # => :updated_at
              :repository   # => nil

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

  def favorite_customer
    successful_invoices = invoices.select(&:successful?)
    totalled_invoices = successful_invoices.group_by do |invoice|
      invoice.customer_id
    end
    favorite_customer_id = totalled_invoices.max_by do |k, v|
      v.count
    end
    repository.find_customer_by_customer_id(favorite_customer_id[0])
  end

  private  # => Merchant

  def successful_invoices_on_date(date)
    result = invoices.select(&:successful?)
    if date
      result.select! { |invoice| invoice.on_date?(date) }
    end
    result
  end
end
