require 'csv'
require_relative 'file_io'
# require_relative 'merchant_repository'

module Repository

  def all
    records
  end

  def random
    records.rand
  end

  def find_by_id
  end

  def find_all_by_id
  end

  def find_by_created_at
  end

  def find_all_by_created_at
  end

  def find_by_updated_at
  end

  def find_all_by_updated_at
  end

end
