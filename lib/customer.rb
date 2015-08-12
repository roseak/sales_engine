class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @first_name = row[:first_name]
    @last_name  = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def invoices
    repository.find_invoices_by_customer_id(id)
  end

  def transactions
    invoices.map(&:transactions)
  end

  def favorite_merchant
    totaled_invoices = invoices.select(&:successful?).group_by(&:merchant_id)
    favorite_merchant_id = totaled_invoices.max_by{|k, v| v.count}
    repository.find_merchant_by_merchant_id(favorite_merchant_id[0])
  end
end
