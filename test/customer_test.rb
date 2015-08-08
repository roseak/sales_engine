require 'minitest/pride'
require 'minitest/autorun'
require './lib/customer_repository'
require './lib/customer'
require './lib/sales_engine'
require './lib/file_io'

class CustomerTest < Minitest::Test
  attr_reader :customer_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @customer_repo = sales_engine.customer_repository
  end

  def test_it_returns_a_collection_of_invoice_instances_with_customer_id
    customer = customer_repo.find_by_id(1)
    invoices = customer.invoices
    assert_equal 11, invoices.count
  end
end
