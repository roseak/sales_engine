require 'minitest/pride'
require 'minitest/autorun'
require './lib/repository'

class LuckyCharms
  include Repository
end

class RepositoryTest < Minitest::Test

  def test_all_returns_entire_collection
    repo = LuckyCharms.new
    merchants = repo.read_data(FileIO.read_csv("./data/merchants.csv"))
    seventh_merchant = merchants.all[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.updated_at
  end

  def test_all_returns_all_instances
    skip
   repo = LuckyCharms.new
   repo.read_data(FileIO.read_csv("./data/merchants.csv"))
   assert_equal 100, repo.all.length
  end


end
