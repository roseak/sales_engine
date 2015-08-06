require_relative 'merchant'
require_relative 'repository'

class MerchantRepository
  # DEFAULT_MERCHANT_FILE = "merchants.csv"

  attr_reader :sales_engine, :records

  include Repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  # def read_data(filename=nil)
    # filename ||= DEFAULT_MERCHANT_FILE

    # data = FileIO.read_csv("#{file_path}/#{filename)}") rescue nil
    # if data
      # @records = data.map do |row|
        # Merchant.new(row)
      # end
    # else
      # {error: 'No file found'}
    # end
  # end

  def read_data(data)
    @records = data.map do |row|
      Merchant.new(row)
    end
  end

end
