require './test/test_helper'

class FileIOTest < Minitest::Test

  def test_csv_reads
    rows = FileIO.read_csv("./data/merchants.csv")
    assert_equal 100, rows.count
  end

end
