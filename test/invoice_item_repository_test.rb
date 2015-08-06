require 'minitest/pride'
require 'minitest/autorun'
require './lib/invoice_item_repository'
require './lib/file_io'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repo, :invoice_items

  def setup
    @invoice_item_repo = InvoiceItemRepository.new("sales_engine")
    @invoice_items = @invoice_item_repo.read_data(FileIO.read_csv("./fixtures/invoice_item_fixture.csv"))
  end

  def test_read_data_returns_invoice_item_instances
    seventh_invoice_item = invoice_items[6]
    assert_equal InvoiceItem, seventh_invoice_item.class
    assert_equal 7, seventh_invoice_item.id
    assert_equal 530, seventh_invoice_item.item_id
    assert_equal 1, seventh_invoice_item.invoice_id
    assert_equal 4, seventh_invoice_item.quantity
    assert_equal "66747", seventh_invoice_item.unit_price
    assert_equal "2012-03-27 14:54:09 UTC", seventh_invoice_item.created_at
    assert_equal "2012-03-27 14:54:09 UTC", seventh_invoice_item.updated_at
  end

  def test_read_data_returns_all_instances
   assert_equal 10, invoice_item_repo.all.length
  end

  def test_all_returns_all_instances_of_invoice_item_class
    seventh_invoice_item = invoice_item_repo.all[6]
    assert_equal InvoiceItem, seventh_invoice_item.class
    assert_equal 7, seventh_invoice_item.id
    assert_equal 530, seventh_invoice_item.item_id
    assert_equal 1, seventh_invoice_item.invoice_id
    assert_equal 4, seventh_invoice_item.quantity
    assert_equal "66747", seventh_invoice_item.unit_price
    assert_equal "2012-03-27 14:54:09 UTC", seventh_invoice_item.created_at
    assert_equal "2012-03-27 14:54:09 UTC", seventh_invoice_item.updated_at
  end

  def test_random_returns_a_random_invoice_item_instance
    invoice_items = 3.times.map { invoice_item_repo.random }
    assert invoice_items.uniq.length > 1
  end

  def test_can_find_invoice_item_by_id
    assert_equal 8, invoice_item_repo.find_by_id(8).id
    assert_equal nil, invoice_item_repo.find_by_id(12)
  end

  def test_can_find_invoice_item_by_item_id
    assert_equal 530, invoice_item_repo.find_by_item_id(530).item_id
    assert_equal nil, invoice_item_repo.find_by_item_id(1000)
  end

  def test_can_find_invoice_item_by_invoice_id
    assert_equal 1, invoice_item_repo.find_by_invoice_id(1).invoice_id
    assert_equal nil, invoice_item_repo.find_by_invoice_id(3)
  end

  def test_can_find_invoice_item_by_quantity
    assert_equal 5, invoice_item_repo.find_by_quantity(5).quantity
    assert_equal nil, invoice_item_repo.find_by_quantity(10)
  end

  def test_can_find_invoice_item_by_unit_price
    skip
    assert_equal "66747", invoice_item_repo.find_by_unit_price("66747").unit_price
    assert_equal nil, invoice_item_repo.find_by_unit_price("65000")
  end

  def test_can_find_invoice_item_by_time_created
    expected = "2012-03-27 14:54:09 UTC"
    assert_equal expected, invoice_item_repo.find_by_created_at("2012-03-27 14:54:09 UTC").created_at
  end

  def test_can_find_invoice_item_by_time_updated
    expected = "2012-03-27 14:54:09 UTC"
    assert_equal expected, invoice_item_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_can_find_all_invoice_items_by_id
    assert_equal 1, invoice_item_repo.find_all_by_id(2).length
    assert_equal [], invoice_item_repo.find_all_by_id(11)
  end

  def test_can_find_all_invoice_items_by_item_id
    assert_equal 1, invoice_item_repo.find_all_by_item_id(530).length
    assert_equal 0, invoice_item_repo.find_all_by_item_id(1000).length
  end

  def test_can_find_all_invoice_items_by_invoice_id
    assert_equal 2, invoice_item_repo.find_all_by_invoice_id(2).length
    assert_equal [], invoice_item_repo.find_all_by_invoice_id(12)
  end

  def test_can_find_all_invoice_items_by_date_created
    assert_equal 10, invoice_item_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC").length
    assert_equal 0, invoice_item_repo.find_all_by_created_at("2012-03-27 16:54:09 UTC").length
  end

  def test_can_find_all_invoice_items_by_date_updated
    assert_equal 10, invoice_item_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC").length
    assert_equal 0, invoice_item_repo.find_all_by_updated_at("2012-02-27 14:54:09 UTC").length
  end
end
