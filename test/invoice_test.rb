require 'minitest/pride'
require 'minitest/autorun'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/sales_engine'
require './lib/file_io'

class InvoiceTest < Minitest::Test

  attr_reader :invoice_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @invoice_repo = sales_engine.invoice_repository
  end

  def test_it_returns_a_collection_of_transactions_associated_with_invoice_id
    invoice      = invoice_repo.find_by_id(1)
    transactions = invoice.transactions
    assert_equal 1, transactions.count
  end

  def test_it_returns_a_collection_of_invoice_items_associated_with_invoice_id
    invoice       = invoice_repo.find_by_id(1)
    invoice_items = invoice.invoice_items
    assert_equal 6, invoice_items.count
  end

  def test_it_returns_a_collection_of_items_associated_with_invoice_id
    skip
    invoice = invoice_repo.find_by_id(3)
    items   = invoice.items
    assert_equal 0, items.count
  end

  def test_it_returns_an_instance_of_customer_associated_with_customer_id
    invoice  = invoice_repo.find_by_id(9)
    customer = invoice.customer
    assert_equal "Cecelia", customer.first_name
  end
end
