require 'minitest/pride'
require 'minitest/autorun'
require './lib/customer_repository'
require './lib/file_io'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :customer_repo, :customers

  def setup
    @customer_repo = CustomerRepository.new("sales_engine")
    @customers     = @customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
  end

  def test_read_data_returns_customer_instances
    seventh_customer = customers[6]
    assert_equal Customer, seventh_customer.class
    assert_equal 7, seventh_customer.id
    assert_equal "Parker", seventh_customer.first_name
    assert_equal "Daugherty", seventh_customer.last_name
    assert_equal "2012-03-27 14:54:10 UTC", seventh_customer.created_at
    assert_equal "2012-03-27 14:54:10 UTC", seventh_customer.updated_at
  end

  def test_read_data_returns_all_instances
    assert_equal 11, customer_repo.all.length
  end

  def test_all_returns_all_instances_of_customer_class
    seventh_customer = customer_repo.all[6]
    assert_equal Customer, seventh_customer.class
    assert_equal 7, seventh_customer.id
    assert_equal "Parker", seventh_customer.first_name
    assert_equal "Daugherty", seventh_customer.last_name
    assert_equal "2012-03-27 14:54:10 UTC", seventh_customer.created_at
    assert_equal "2012-03-27 14:54:10 UTC", seventh_customer.updated_at
  end

  def test_random_returns_a_random_customer_instance
    customers = 3.times.map { customer_repo.random }
    assert customers.uniq.length > 1
  end

  def test_can_find_customer_by_id
    assert_equal 8, customer_repo.find_by_id(8).id
  end

  def test_returns_nil_when_record_with_id_not_found
    assert_equal nil, customer_repo.find_by_id(12)
  end

  def test_can_find_customer_by_first_name
    expected = "Dejon"
    assert_equal expected, customer_repo.find_by_first_name("Dejon").first_name
  end

  def test_can_find_customer_by_first_name_case_insensitive
    expected = "Dejon"
    assert_equal expected, customer_repo.find_by_first_name("dejon").first_name
  end

  def test_can_find_customer_by_last_name
    expected = "Toy"
    assert_equal expected, customer_repo.find_by_last_name("Toy").last_name
  end

  def test_can_find_customer_by_las_name_case_insensitive
    expected = "Nader"
    assert_equal expected, customer_repo.find_by_last_name("nader").last_name
  end

  def test_does_not_return_name_when_only_part_matches
    expected = nil
    assert_equal expected, customer_repo.find_by_first_name("Ramon")
  end

  def test_no_first_name
    assert_equal nil, customer_repo.find_by_first_name(nil)
  end

  def test_no_last_name
    assert_equal nil, customer_repo.find_by_last_name(nil)
  end

  def test_can_find_customer_by_time_created
    expected = "2012-03-27 14:54:09 UTC"
    assert_equal expected, customer_repo.find_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_can_find_customer_by_time_updated
    expected = "2012-03-27 14:54:11 UTC"
    assert_equal expected, customer_repo.find_by_updated_at("2012-03-27 14:54:11 UTC").updated_at
  end

  def test_can_find_all_customers_by_id
    assert_equal 1, customer_repo.find_all_by_id(2).length
    assert_equal 0, customer_repo.find_all_by_id(12).length
  end

  def test_can_find_all_customers_by_first_name
    assert_equal 2, customer_repo.find_all_by_first_name("Mariah").length
    assert_equal 0, customer_repo.find_all_by_first_name("David and Rose").length
  end

  def test_can_find_all_customers_by_last_name
    assert_equal 2, customer_repo.find_all_by_last_name("Toy").length
    assert_equal 0, customer_repo.find_all_by_last_name("David and Rose").length
  end

  def test_can_find_all_customers_by_date_created
    assert_equal 7, customer_repo.find_all_by_created_at("2012-03-27 14:54:10 UTC").length
    assert_equal 0, customer_repo.find_all_by_created_at("2012-04-27 14:53:59 UTC").length
  end

  def test_can_find_all_customers_by_date_updated
    assert_equal 7, customer_repo.find_all_by_updated_at("2012-03-27 14:54:10 UTC").length
    assert_equal 0, customer_repo.find_all_by_updated_at("2012-03-27 19:53:59 UTC").length
  end

end
