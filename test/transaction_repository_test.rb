require 'minitest/pride'
require 'minitest/autorun'
require './lib/transaction_repository'
require './lib/file_io'

class TransactionRepositoryTest < Minitest::Test
  def test_read_data_returns_transaction_instances
    transaction_repo    = TransactionRepository.new("sales_engine")
    transactions = transaction_repo.read_data(FileIO.read_csv("./fixtures/transaction_fixture.csv"))
    seventh_transaction = transactions[6]
    assert_equal Transaction, seventh_transaction.class
    assert_equal 7, seventh_transaction.id
    assert_equal "8", seventh_transaction.invoice_id
    assert_equal "2012-03-27 14:53:59 UTC", seventh_transaction.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_transaction.updated_at
  end

  def test_read_data_returns_all_instances
   merchant_repo = MerchantRepository.new("sales_engine")
   merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
   assert_equal 100, merchant_repo.all.length
  end

  def test_all_returns_all_instances_of_merchant_class
    merchant_repo    = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    seventh_merchant = merchant_repo.all[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.updated_at
  end

  def test_random_returns_a_random_merchant_instance
    merchant_repo    = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    merchants = 3.times.map { merchant_repo.random }
    assert merchants.uniq.length > 1
  end

  def test_can_find_merchant_by_id
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    assert_equal 8, merchant_repo.find_by_id(8).id
  end

  def test_can_find_merchant_by_name
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    expected = "Osinski, Pollich and Koelpin"
    assert_equal expected, merchant_repo.find_by_name("Osinski, Pollich and Koelpin").name
  end

  def test_can_find_merchant_by_time_created
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_can_find_merchant_by_time_updated
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, merchant_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_can_find_all_merchants_by_id
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./fixtures/merchant_fixture.csv"))
    assert_equal 1, merchant_repo.find_all_by_id(2).length
    assert_equal 0, merchant_repo.find_all_by_id(11).length
  end

  def test_can_find_all_merchants_by_name
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./fixtures/merchant_fixture.csv"))
    assert_equal 2, merchant_repo.find_all_by_name("Williamson Group").length
    assert_equal 0, merchant_repo.find_all_by_name("David and Rose").length
  end

  def test_can_find_all_merchants_by_date_created
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./fixtures/merchant_fixture.csv"))
    assert_equal 10, merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, merchant_repo.find_all_by_created_at("2012-04-27 14:53:59 UTC").length
  end

  def test_can_find_all_merchants_by_date_updated
    merchant_repo   = MerchantRepository.new("sales_engine")
    merchant_repo.read_data(FileIO.read_csv("./fixtures/merchant_fixture.csv"))
    assert_equal 8, merchant_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, merchant_repo.find_all_by_updated_at("2012-03-27 19:53:59 UTC").length
  end
end
