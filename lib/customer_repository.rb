require_relative 'customer'
require_relative 'repository'

class CustomerRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Customer.new(row)
    end
  end

  def find_by_first_name(first_name)
    records.find{|record| record.first_name.upcase == first_name.upcase}
  end

  def find_by_last_name(last_name)
    records.find{|record| record.last_name.upcase == last_name.upcase}
  end

end
