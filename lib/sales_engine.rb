require 'csv'

class Parser
  def self.parse(file)
    data = CSV.open file, headers: true, header_converters: :symbol
  end
end
