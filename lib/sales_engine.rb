require_relative 'merchant_repository'
require_relative 'transaction_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'file_io'

class SalesEngine

  attr_reader :merchant_repository, :transaction_repository, :customer_repository, :file_path

  def initialize(file_path = "./data")
    @file_path = file_path
    @merchant_repository = MerchantRepository.new(self)
    @customer_repository = CustomerRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
  end

  def startup
    merchant_repository.read_data(FileIO.read_csv("#{file_path}/merchants.csv"))
    customer_repository.read_data(FileIO.read_csv("#{file_path}/customers.csv"))
    transaction_repository.read_data(FileIO.read_csv("#{file_path}/transactions.csv"))
  end

end
