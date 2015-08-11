require 'minitest/pride'
require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/sales_engine'
require './lib/file_io'

class MerchantTest < Minitest::Test
  attr_reader :merchant_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @merchant_repo = sales_engine.merchant_repository
  end

  def test_it_returns_a_collection_of_items_associated_with_merchant_id
    merchant = merchant_repo.find_by_id(1)
    items    = merchant.items
    assert_equal 10, items.count
  end

  def test_it_returns_a_collection_of_invoices_associated_with_merchant_id
    merchant = merchant_repo.find_by_id(1)
    invoices = merchant.invoices
    assert_equal 3, invoices.count
  end

  def test_revenue_returns_total_revenue_for_merchant
    merchant = merchant_repo.find_by_id(1)
    merchant2 = merchant_repo.find_by_id(2)
    assert_equal BigDecimal("831.07"), merchant.revenue
    assert_equal BigDecimal("720.76"), merchant2.revenue
  end

  def test_a_merchant_with_no_sales_has_no_revenue
    merchant = merchant_repo.find_by_id(3)
    assert_equal BigDecimal("0"), merchant.revenue
  end

  def test_revenue_only_includes_invoices_with_successful_transactions
    merchant = merchant_repo.find_by_id(4)
    assert_equal BigDecimal("5"), merchant.revenue
  end

  def test_revenue_can_filtered_by_date
    merchant = merchant_repo.find_by_id(1)
    date = Date.new(2012, 3, 7)
    assert_equal BigDecimal("751.07"), merchant.revenue(date)
  end

  def test_favorite_customer_returns_the_customer_with_the_most_successful_transactions
    merchant = merchant_repo.find_by_id(1)
    assert_equal "Ondricka", merchant.favorite_customer.last_name
  end

  def test_can_return_collection_of_customers_with_pending_invoices
    merchant = merchant_repo.find_by_id(11)
    assert_equal 1, merchant.customers_with_pending_invoices.length
  end

  def test_customer_does_not_have_pending_invoices_if_all_transactions_are_not_unsuccessful
    skip
    merchant = merchant_repo.find_by_id(11)
    assert_equal nil, merchant.customers_with_pending_invoices
  end
end
