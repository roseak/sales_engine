require_relative 'transaction'
require_relative 'repository'

class TransactionRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_credit_card_number(credit_card_number)
    records.find{|record| record.credit_card_number == credit_card_number}
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    records.find{|record| record.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_by_result(result)
    records.find{|record| record.result == result}
  end

  def find_all_by_credit_card_number(credit_card_number)
    records.select{|record| record.credit_card_number == credit_card_number}
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    records.select{|record| record.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_all_by_result(result)
    records.select{|record| record.result == result}
  end

  def find_invoice_by_invoice_id(invoice_id)
    sales_engine.find_invoice_by_invoice_id(invoice_id)
  end
end
