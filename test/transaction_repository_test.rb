require 'minitest/pride'
require 'minitest/autorun'
require './lib/transaction_repository'
require './lib/file_io'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repo, :transactions

  def setup
    @transaction_repo = TransactionRepository.new("sales_engine")
    @transactions = @transaction_repo.read_data(FileIO.read_csv("./fixtures/transaction_fixture.csv"))
  end

  def test_read_data_returns_transaction_instances
    seventh_transaction = transactions[6]
    assert_equal Transaction, seventh_transaction.class
    assert_equal 7, seventh_transaction.id
    assert_equal 8, seventh_transaction.invoice_id
    assert_equal "4801647818676136", seventh_transaction.credit_card_number
    assert_equal nil, seventh_transaction.credit_card_expiration_date
    assert_equal "2012-03-27 14:54:10 UTC", seventh_transaction.created_at
    assert_equal "2012-03-27 14:54:10 UTC", seventh_transaction.updated_at
  end

  def test_read_data_returns_all_instances
   assert_equal 10, transaction_repo.all.length
  end

  def test_all_returns_all_instances_of_transaction_class
    seventh_transaction = transaction_repo.all[6]
    assert_equal Transaction, seventh_transaction.class
    assert_equal 7, seventh_transaction.id
    assert_equal 8, seventh_transaction.invoice_id
    assert_equal "4801647818676136", seventh_transaction.credit_card_number
    assert_equal nil, seventh_transaction.credit_card_expiration_date
    assert_equal "2012-03-27 14:54:10 UTC", seventh_transaction.created_at
    assert_equal "2012-03-27 14:54:10 UTC", seventh_transaction.updated_at
  end

  def test_random_returns_a_random_transaction_instance
    transactions = 3.times.map { transaction_repo.random }
    assert transactions.uniq.length > 1
  end

  def test_can_find_transaction_by_id
    assert_equal 8, transaction_repo.find_by_id(8).id
  end

  def test_can_find_transaction_by_invoice_id
    assert_equal 4, transaction_repo.find_by_invoice_id(4).invoice_id
  end

  def test_can_find_transaction_by_credit_card_number
    expected = "4801647818676136"
    assert_equal expected, transaction_repo.find_by_credit_card_number(expected).credit_card_number
  end

  def test_can_find_transaction_by_time_created
    expected = "2012-03-27 14:54:10 UTC"
    assert_equal expected, transaction_repo.find_by_created_at("2012-03-27 14:54:10 UTC").created_at
  end

  def test_can_find_transaction_by_time_updated
    expected = "2012-03-27 14:54:10 UTC"
    assert_equal expected, transaction_repo.find_by_updated_at("2012-03-27 14:54:10 UTC").updated_at
  end

  def test_can_find_all_transactions_by_id
    assert_equal 1, transaction_repo.find_all_by_id(2).length
    assert_equal [], transaction_repo.find_all_by_id(11)
  end

  def test_can_find_all_transactions_by_invoice_id
    assert_equal 1, transaction_repo.find_all_by_invoice_id(4).length
    assert_equal [], transaction_repo.find_all_by_invoice_id(12)
  end

  def test_can_find_all_transactions_by_date_created
    assert_equal 2, transaction_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").length
    assert_equal 0, transaction_repo.find_all_by_created_at("2012-03-27 16:54:09 UTC").length
  end

  def test_can_find_all_transactions_by_date_updated
    assert_equal 2, transaction_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").length
    assert_equal 0, transaction_repo.find_all_by_updated_at("2012-02-27 14:54:09 UTC").length
  end
end
