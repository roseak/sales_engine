require_relative 'merchant_repository'

class SalesEngine

  def startup
  end

  def merchant_repository
    MerchantRepository.new
  end
end

# require 'csv'
# #
# # class Parser
# #   def self.parse(file)
# #     data = CSV.open file, headers: true, header_converters: :symbol
# #   end
# # end
