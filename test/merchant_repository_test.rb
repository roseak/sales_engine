require 'minitest/pride'
require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/file_io'

class MerchantRepositoryTest < Minitest::Test

  def test_read_data_returns_merchant_instances
    merchant_repo    = MerchantRepository.new("sales_engine")
    merchants = merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    seventh_merchant = merchants[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.updated_at
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

end
