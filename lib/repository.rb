require 'csv'

module Repository
  def all
    CSV.read "data/#{repo_file_name}", headers: true, header_converters: :symbol
  end
end
