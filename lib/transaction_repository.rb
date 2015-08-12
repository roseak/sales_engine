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
    records.find do |record|
      record.credit_card_expiration_date == credit_card_expiration_date
    ends
  end

  def find_by_result(result)
    records.find{|record| record.result == result}
  end

  def find_all_by_credit_card_number(credit_card_number)
    records.select{|record| record.credit_card_number == credit_card_number}
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    records.select do |record|
      record.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_all_by_result(result)
    records.select{|record| record.result == result}
  end

  def find_invoice_by_invoice_id(invoice_id)
    sales_engine.find_invoice_by_invoice_id(invoice_id)
  end

  def charge(payment_data, invoice_id)
    credit_card_number = payment_data[:credit_card_number]
    credit_card_expiration_date = payment_data[:credit_card_expiration_date]
    result = payment_data[:result]
    new_transaction = Transaction.new(
        {id: next_id,
         invoice_id: invoice_id,
         credit_card_number: credit_card_number,
         credit_card_expiration_date: credit_card_expiration_date,
         result: result,
         created_at: Time.now.strftime("%c %d, %Y"),
         updated_at: Time.now.strftime("%c %d, %Y")},
         self)
    records << new_transaction
  end

  def next_id
    if records.last.nil?
      1
    else
      records.last.id.next
    end
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end
end
