require 'csv'
require_relative 'file_io'
# require_relative 'merchant_repository'

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
    records.find{|record| record.name == name}
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

  def find_all_by_created_at
  end

  def find_all_by_updated_at
  end

end
