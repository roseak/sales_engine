require './test/test_helper'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item_repo

  def setup
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    @invoice_item_repo = sales_engine.invoice_item_repository
  end

  def test_invoice_item_returns_an_instance_of_invoice
    invoice_item  = invoice_item_repo.find_by_id(2)
    invoice = invoice_item.invoice
    assert_equal "shipped", invoice.status
  end

  def test_invoice_item_returns_an_instance_of_item
    invoice_item = invoice_item_repo.find_by_id(2)
    item         = invoice_item.item
    assert_equal "Item Est Consequuntur", item.name
  end
end
