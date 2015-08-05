require_relative 'merchant'
require_relative 'repository'

class MerchantRepository

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def read_data(data)
    @records = data.map do |row|
      Merchant.new(row)
    end
  end
  
  # # private
  #
  # def repo_file_name
  #   "merchants.csv"
  # end
end
