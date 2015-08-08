require 'minitest/pride'
require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/file_io'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo, :merchants

  def setup
    @merchant_repo = MerchantRepository.new("sales_engine")
    @merchants = @merchant_repo.read_data(FileIO.read_csv("./fixtures/merchants.csv"))
  end

  def test_read_data_returns_merchant_instances
    seventh_merchant = merchants[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.updated_at
  end

  def test_read_data_returns_all_instances
   assert_equal 10, merchant_repo.all.length
  end

  def test_all_returns_all_instances_of_merchant_class
    seventh_merchant = merchant_repo.all[6]
    assert_equal Merchant, seventh_merchant.class
    assert_equal 7, seventh_merchant.id
    assert_equal "Bernhard-Johns", seventh_merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_merchant.updated_at
  end

  def test_random_returns_a_random_merchant_instance
    merchants = 3.times.map { merchant_repo.random }
    assert merchants.uniq.length > 1
  end

  def test_can_find_merchant_by_id
    assert_equal 8, merchant_repo.find_by_id(8).id
  end

  def test_returns_nil_when_record_with_id_not_found
    assert_equal nil, merchant_repo.find_by_id(11)
  end

  #TODO: repeat assertions for repo methods that are sad paths

  def test_can_find_merchant_by_name
    expected = "Osinski, Pollich and Koelpin"
    assert_equal expected, merchant_repo.find_by_name("Osinski, Pollich and Koelpin").name
  end

  def test_can_find_merchant_by_name_case_insensitive
    expected = "Osinski, Pollich and Koelpin"
    assert_equal expected, merchant_repo.find_by_name("osinski, Pollich and Koelpin").name
  end

  def test_does_not_return_name_when_only_part_matches
    expected = nil
    assert_equal expected, merchant_repo.find_by_name("Osinski")
  end

  def test_no_name
    assert_equal nil, merchant_repo.find_by_name(nil)
  end

  def test_can_find_merchant_by_time_created
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_can_find_merchant_by_time_updated
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, merchant_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_can_find_all_merchants_by_id
    assert_equal 1, merchant_repo.find_all_by_id(2).length
    assert_equal 0, merchant_repo.find_all_by_id(11).length
  end

  def test_can_find_all_merchants_by_name
    assert_equal 2, merchant_repo.find_all_by_name("Williamson Group").length
    assert_equal 0, merchant_repo.find_all_by_name("David and Rose").length
  end

  def test_can_find_all_merchants_by_date_created
    assert_equal 10, merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, merchant_repo.find_all_by_created_at("2012-04-27 14:53:59 UTC").length
  end

  def test_can_find_all_merchants_by_date_updated
    assert_equal 8, merchant_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, merchant_repo.find_all_by_updated_at("2012-03-27 19:53:59 UTC").length
  end
end
