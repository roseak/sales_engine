require 'minitest/pride'
require 'minitest/autorun'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_merchant_repository_exists
    engine = SalesEngine.new
    assert_equal MerchantRepository, engine.merchant_repository.class
  end

end
