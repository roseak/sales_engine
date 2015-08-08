require 'minitest/pride'
require 'minitest/autorun'
require './lib/transaction_repository'
require './lib/transaction'
require './lib/sales_engine'
require './lib/file_io'

class TransactionTest < Minitest::Test
  attr_reader :transaction_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @transaction_repo = sales_engine.transaction_repository
  end

  def test_it_returns_an_instance_of_invoice_associated_with_transaction_id
    transaction = transaction_repo.find_by_id(4)
    invoice     = transaction.invoice
    assert_equal 1, invoice.merchant_id
  end
end
