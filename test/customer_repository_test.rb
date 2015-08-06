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
    assert_equal 10, customer_repo.all.length
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
    assert_equal nil, customer_repo.find_by_id(11)
  end

  def test_can_find_customer_by_first_name
    expected = "Dejon"
    assert_equal expected, customer_repo.find_by_first_name("Dejon").first_name
  end

  def test_can_find_customer_by_last_name
    expected = "Toy"
    assert_equal expected, customer_repo.find_by_last_name("Toy").last_name
  end

  def test_can_find_Customer_by_time_created
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, customer_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_can_find_Customer_by_time_updated
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, customer_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_can_find_all_customers_by_id
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    assert_equal 1, customer_repo.find_all_by_id(2).length
    assert_equal 0, customer_repo.find_all_by_id(11).length
  end

  def test_can_find_all_customers_by_first_name
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    assert_equal 2, customer_repo.find_all_by_name("Williamson Group").length
    assert_equal 0, customer_repo.find_all_by_name("David and Rose").length
  end

  def test_can_find_all_customers_by_last_name
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    assert_equal 2, customer_repo.find_all_by_name("Williamson Group").length
    assert_equal 0, customer_repo.find_all_by_name("David and Rose").length
  end

  def test_can_find_all_customers_by_date_created
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    assert_equal 10, customer_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, customer_repo.find_all_by_created_at("2012-04-27 14:53:59 UTC").length
  end

  def test_can_find_all_customers_by_date_updated
    skip
    customer_repo   = CustomerRepository.new("sales_engine")
    customer_repo.read_data(FileIO.read_csv("./fixtures/customer_fixture.csv"))
    assert_equal 8, customer_repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC").length
    assert_equal 0, customer_repo.find_all_by_updated_at("2012-03-27 19:53:59 UTC").length
  end

end
