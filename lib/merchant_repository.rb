require_relative 'merchant'
require_relative 'repository'

class MerchantRepository
  include Repository

  private

  def repo_file_name
    "merchants.csv"
  end
end
