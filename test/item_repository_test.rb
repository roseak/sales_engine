require 'minitest/pride'
require 'minitest/autorun'
require './lib/item_repository'
require './lib/file_io'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo, :items

  def setup
    @item_repo = ItemRepository.new("sales_engine")
    @items     = @item_repo.read_data(FileIO.read_csv("./fixtures/item_fixture.csv"))
  end

  def test_read_data_returns_item_instances
    seventh_item = items[6]
    assert_equal Item, seventh_item.class
    assert_equal 7, seventh_item.id
    assert_equal "Item Expedita Fuga", seventh_item.name
    assert_equal "Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.", seventh_item.description
    assert_equal 311.63, seventh_item.unit_price
    assert_equal 1, seventh_item.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", seventh_item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_item.updated_at
  end

  def test_read_data_returns_all_instances
    assert_equal 10, item_repo.all.length
  end

  def test_all_returns_all_instances_of_item_class
    seventh_item = item_repo.all[6]
    assert_equal Item, seventh_item.class
    assert_equal 7, seventh_item.id
    assert_equal "Item Expedita Fuga", seventh_item.name
    assert_equal "Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.", seventh_item.description
    assert_equal 311.63, seventh_item.unit_price
    assert_equal 1, seventh_item.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", seventh_item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", seventh_item.updated_at
  end

  def test_random_returns_a_random_item_instance
    items = 3.times.map { item_repo.random }
    assert items.uniq.length > 1
  end

  def test_can_find_item_by_id
    assert_equal 8, item_repo.find_by_id(8).id
  end

  def test_returns_nil_when_record_with_id_not_found
    assert_equal nil, item_repo.find_by_id(12)
  end

  def test_can_find_item_by_name
    expected = "Item Qui Esse"
    assert_equal expected, item_repo.find_by_name("Item Qui Esse").name
  end

  def test_can_find_item_by_name_case_insensitive
    expected = "Item Qui Esse"
    assert_equal expected, item_repo.find_by_name("item Qui Esse").name
  end

  def test_does_not_return_name_when_only_part_matches
    expected = nil
    assert_equal expected, item_repo.find_by_name("Item")
  end

  def test_no_name
    assert_equal nil, item_repo.find_by_name(nil)
  end

  def test_can_find_item_by_description
    expected = "Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet."
    assert_equal expected, item_repo.find_by_description("Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.").description
  end

  def test_can_find_item_by_unit_price
    expected = 311.63
    assert_equal expected, item_repo.find_by_unit_price(311.63).unit_price
  end

  def test_can_find_item_by_merchant_id
    expected = 1
    assert_equal expected, item_repo.find_by_merchant_id(1).merchant_id
  end

  def test_can_find_item_by_time_created
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, item_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_can_find_item_by_time_updated
    expected = "2012-03-27 14:53:59 UTC"
    assert_equal expected, item_repo.find_by_updated_at("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_can_find_all_items_by_id
    assert_equal 2, item_repo.find_all_by_id(4).length
    assert_equal 0, item_repo.find_all_by_id(12).length
  end

  def test_can_find_all_items_by_name
    assert_equal 2, item_repo.find_all_by_name("Item Nemo Facere").length
    assert_equal 0, item_repo.find_all_by_name("David and Rose").length
  end

  def test_can_find_all_items_by_last_name
    skip
    assert_equal 2, item_repo.find_all_by_last_name("Toy").length
    assert_equal 0, item_repo.find_all_by_last_name("David and Rose").length
  end

  def test_can_find_all_items_by_date_created
    skip
    assert_equal 7, item_repo.find_all_by_created_at("2012-03-27 14:54:10 UTC").length
    assert_equal 0, item_repo.find_all_by_created_at("2012-04-27 14:53:59 UTC").length
  end

  def test_can_find_all_items_by_date_updated
    skip
    assert_equal 7, item_repo.find_all_by_updated_at("2012-03-27 14:54:10 UTC").length
    assert_equal 0, item_repo.find_all_by_updated_at("2012-03-27 19:53:59 UTC").length
  end

end
