require 'minitest/pride'
require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/file_io'

class MerchantRepositoryTest < Minitest::Test

  def test_read_data_returns_merchant_instances
    merchant_repo    = MerchantRepository.new
    merchants = merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    seventh_merchant = merchants[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    # assert_equal 7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
  end

  def test_all_returns_all_instances
   merchant_repo = MerchantRepository.new
   merchant_repo.read_data(FileIO.read_csv("./data/merchants.csv"))
   assert_equal 100, merchant_repo.all.length
 end
end
