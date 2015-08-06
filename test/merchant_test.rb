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

end
