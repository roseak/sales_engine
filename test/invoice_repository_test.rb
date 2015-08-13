require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo, :invoices

  def setup
    @invoice_repo = InvoiceRepository.new("sales_engine")
    @invoices = @invoice_repo.read_data(FileIO.read_csv("./fixtures/invoices.csv"))
  end

  def test_read_data_returns_invoice_instances
    seventh_invoice = invoices[6]
    assert_equal Invoice, seventh_invoice.class
    assert_equal 7, seventh_invoice.id
    assert_equal 1, seventh_invoice.customer_id
    assert_equal 44, seventh_invoice.merchant_id
    assert_equal "shipped", seventh_invoice.status
    assert_equal "2012-03-07 21:54:10 UTC", seventh_invoice.created_at
    assert_equal "2012-03-07 21:54:10 UTC", seventh_invoice.updated_at
  end

  def test_read_data_returns_all_instances
   assert_equal 16, invoice_repo.all.length
  end

  def test_all_returns_all_invoice_instances
    seventh_invoice = invoice_repo.all[6]
    assert_equal Invoice, seventh_invoice.class
    assert_equal 7, seventh_invoice.id
    assert_equal 1, seventh_invoice.customer_id
    assert_equal 44, seventh_invoice.merchant_id
    assert_equal "shipped", seventh_invoice.status
    assert_equal "2012-03-07 21:54:10 UTC", seventh_invoice.created_at
    assert_equal "2012-03-07 21:54:10 UTC", seventh_invoice.updated_at
  end

  def test_random_returns_a_random_invoice_instance
    invoices = 3.times.map { invoice_repo.random }
    assert invoices.uniq.length > 1
  end

  def test_can_find_invoice_by_id
    assert_equal 8, invoice_repo.find_by_id(8).id
    assert_equal nil, invoice_repo.find_by_id(19)
  end

  def test_can_find_invoice_by_customer_id
    assert_equal 1, invoice_repo.find_by_customer_id(1).customer_id
    assert_equal nil, invoice_repo.find_by_customer_id(6)
  end

  def test_can_find_invoice_by_merchant_id
    assert_equal 26, invoice_repo.find_by_merchant_id(26).merchant_id
    assert_equal nil, invoice_repo.find_by_merchant_id(3)
  end

  def test_can_find_invoice_by_status
    assert_equal "shipped", invoice_repo.find_by_status("shipped").status
    assert_equal nil, invoice_repo.find_by_status("not shipped")
  end

  def test_can_find_invoice_by_time_created
    expected = "2012-03-25 09:54:09 UTC"
    assert_equal expected, invoice_repo.find_by_created_at("2012-03-25 09:54:09 UTC").created_at
  end

  def test_can_find_invoice_by_time_updated
    expected = "2012-03-25 09:54:09 UTC"
    assert_equal expected, invoice_repo.find_by_updated_at("2012-03-25 09:54:09 UTC").updated_at
  end

  def test_can_find_all_invoices_by_id
    assert_equal 1, invoice_repo.find_all_by_id(2).length
    assert_equal 0, invoice_repo.find_all_by_id(19).length
  end

  def test_can_find_all_invoices_by_customer_id
    assert_equal 12, invoice_repo.find_all_by_customer_id(1).length
    assert_equal 0, invoice_repo.find_all_by_customer_id(5).length
  end

  def test_can_find_all_invoices_by_merchant_id
    assert_equal 1, invoice_repo.find_all_by_merchant_id(33).length
    assert_equal 0, invoice_repo.find_all_by_merchant_id(12).length
  end

  def test_can_find_all_invoices_by_status
    assert_equal 16, invoice_repo.find_all_by_status("shipped").length
    assert_equal 0, invoice_repo.find_all_by_status("not shipped").length
  end

  def test_can_find_all_invoices_by_date_created
    assert_equal 1, invoice_repo.find_all_by_created_at("2012-03-25 09:54:09 UTC").length
    assert_equal 0, invoice_repo.find_all_by_created_at("2012-03-27 16:54:09 UTC").length
  end

  def test_can_find_all_invoices_by_date_updated
    assert_equal 1, invoice_repo.find_all_by_updated_at("2012-03-25 09:54:09 UTC").length
    assert_equal 0, invoice_repo.find_all_by_updated_at("2012-02-27 14:54:09 UTC").length
  end

  def test_create_makes_invoices
    sales_engine = SalesEngine.new("./fixtures")
    data = sales_engine.startup
    item = sales_engine.item_repository.find_by_id(1)
    customer = sales_engine.customer_repository.find_by_id(1)
    merchant = sales_engine.merchant_repository.find_by_id(1)
    invoice = sales_engine.invoice_repository.create(customer: customer, merchant: merchant, status: "shipped", items:[item])
    assert_equal invoice, sales_engine.invoice_repository.all.last
  end
end
