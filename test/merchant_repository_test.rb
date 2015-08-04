require 'minitest/pride'
require 'minitest/autorun'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_all_returns_merchant_instances
    merchant_repo = MerchantRepository.new
    seventh_merchant = merchant_repo.all[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    # assert_equal 7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
  end

  def test_all_returns_all_instances
   merchant_repo = MerchantRepository.new
   assert_equal 100, merchant_repo.all.length
 end
end
