require 'minitest/pride'
require 'minitest/autorun'
require './lib/file_io'
require 'pry'

class FileIOTest < Minitest::Test

  def test_csv_reads
    rows = FileIO.read_csv("./data/merchants.csv")
    assert_equal 100, rows.count
  end

end
