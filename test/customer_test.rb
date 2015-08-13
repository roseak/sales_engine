require './test/test_helper'

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
    assert_equal 12, invoices.count
  end

  def test_transactions_returns_a_collection_of_transactions_by_customer
    customer = customer_repo.find_by_id(1)
    assert_equal 12, customer.transactions.count
  end

  def test_favorite_merchant_returns_the_merchant_with_the_most_successful_transactions
    customer = customer_repo.find_by_id(1)
    assert_equal "Schroeder-Jerde", customer.favorite_merchant.name
  end
end
