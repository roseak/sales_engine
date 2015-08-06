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

  def find_by_description(description)
    if description
      records.find do |record|
        return if !record.description
        record.description.upcase == description.upcase
      end
    else
      nil
    end
  end

  def find_all_by_description(description)
    records.select{|record| record.description == description}
  end

  

end
