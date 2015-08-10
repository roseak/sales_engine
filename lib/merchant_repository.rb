require_relative 'merchant'
require_relative 'repository'

class MerchantRepository
  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_items_by_merchant_id(merchant_id)
    sales_engine.find_items_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    sales_engine.find_invoices_by_merchant_id(merchant_id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def most_revenue(x)
    rank_merchants = records.sort_by(&:revenue)
    rank_merchants.reverse[0..(x-1)]
  end

  def most_items(x)
    rank_merchants = records.sort_by(&:total_items)
    rank_merchants.reverse[0..(x-1)]
  end

  def revenue(date)
    records.map do |merchant|
      merchant.revenue(date)
    end
  end
end
