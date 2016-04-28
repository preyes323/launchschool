class Triangle
  attr_reader :rows

  def initialize(num_rows)
    @rows = make_triangle(num_rows)
  end

  private

  def make_triangle num_rows
    num_rows.times.each_with_object([]) do |row_num, result|
      result << (result.empty? ? [1] : make_row(result[row_num - 1]))
    end
  end

  def make_row previous_row
    row = (previous_row.size - 1).times.each_with_object([1]) do |idx, result|
        result << previous_row[idx] + previous_row[idx + 1]
    end

    row.push(1)
  end
end
