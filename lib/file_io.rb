require 'csv'

class FileIO

  def self.read_csv(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

end
