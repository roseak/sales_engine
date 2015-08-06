require_relative 'item'
require_relative 'repository'

class ItemRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Item.new(row)
    end
  end

  def find_by_first_name(first_name)
    if first_name
      records.find do |record|
        return if !record.first_name
        record.first_name.upcase == first_name.upcase
      end
    else
      nil
    end
  end

  def find_by_last_name(last_name)
    if last_name
      records.find do |record|
        return if !record.last_name
        record.last_name.upcase == last_name.upcase
    end
    else
      nil
    end
  end

  def find_all_by_first_name(first_name)
    records.select{|record| record.first_name.upcase == first_name.upcase}
  end

  def find_all_by_last_name(last_name)
    records.select{|record| record.last_name.upcase == last_name.upcase}
  end
end
