require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository
  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_customer_id(customer_id)
    records.find{|record| record.customer_id == customer_id}
  end

  def find_by_status(status)
    records.find{|record| record.status == status}
  end

  def find_all_by_customer_id(customer_id)
    records.select{|record| record.customer_id == customer_id}
  end

  def find_all_by_status(status)
    records.select{|record| record.status == status}
  end

  def find_transactions_by_invoice_id(invoice_id)
    sales_engine.find_transactions_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    sales_engine.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def create(invoice_data)
    customer    = invoice_data[:customer]
    merchant    = invoice_data[:merchant]
    status      = invoice_data[:status]
    items       = invoice_data[:items]
    new_invoice = Invoice.new({id: next_invoice_id,
                               customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: status,
                               created_at: Time.now.strftime("%c %d, %Y"),
                               updated_at: Time.now.strftime("%c %d, %Y")},
                               self)
    records << new_invoice
    sales_engine.create_invoice_items(items, new_invoice.id)
    new_invoice
  end

  def next_invoice_id
    if records.last.nil?
      1
    else
      records.last.id.next
    end
  end

  def charge(payment_data, id)
    sales_engine.charge(payment_data, id)
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end
end
