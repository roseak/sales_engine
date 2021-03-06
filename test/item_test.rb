require './test/test_helper'

class ItemTest < Minitest::Test
  attr_reader :item_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @item_repo = sales_engine.item_repository
  end

  def test_it_returns_a_collection_of_invoice_items_associated_with_item_id
    item          = item_repo.find_by_id(528)
    invoice_items = item.invoice_items
    assert_equal 1, invoice_items.count
  end

  def test_it_returns_an_instance_of_merchant_associated_with_item_id
    item          = item_repo.find_by_id(1)
    merchant      = item.merchant
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_revenue_can_filtered_by_date
    item = item_repo.find_by_id(1)
    assert_equal Date.new(2012, 3, 7), item.best_day
  end
end
