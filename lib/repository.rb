require 'csv'
require_relative 'file_io'

module Repository

  def all
    records
  end

  def random
    records.sample
  end

  def find_by_id(id)
    records.find{|record| record.id == id}
  end

  def find_by_name(name)
    if name
      records.find do |record|
        return if !record.name
        record.name.upcase == name.upcase
      end
    else
      nil
    end
  end

  def find_by_invoice_id(invoice_id)
    records.find{|record| record.invoice_id == invoice_id}
  end

  def find_by_unit_price(unit_price)
    records.find{|record| record.unit_price == unit_price}
  end

  def find_by_created_at(created_at)
    records.find{|record| record.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    records.find{|record| record.updated_at == updated_at}
  end

  def find_all_by_id(id)
    records.select{|record| record.id == id}
  end

  def find_all_by_name(name)
    records.select{|record| record.name == name}
  end

  def find_all_by_invoice_id(invoice_id)
    records.select{|record| record.invoice_id == invoice_id}
  end

  def find_all_by_unit_price(unit_price)
    records.select{|record| record.unit_price == unit_price}
  end

  def find_all_by_created_at(created_at)
    records.select{|record| record.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    records.select{|record| record.updated_at == updated_at}
  end

end
