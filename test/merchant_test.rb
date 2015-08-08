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
    assert_equal 2, invoices.count
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

  def test_revenue_can_filter_by_date
    merchant = merchant_repo.find_by_id(1)
    date = Date.new(2012, 3, 7)
    assert_equal BigDecimal("751.07"), merchant.revenue(date)
  end
end
