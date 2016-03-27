class Matrix
  attr_reader :rows, :columns

  def initialize(cell_values)
    @rows = cell_values.split("\n").map(&:split).map do |row|
      row.map(&:to_i)
    end

    @columns = rows.transpose
  end

  def saddle_points
    rows.each_with_index.each_with_object([]) do |(row, row_idx), result|
      row.each_with_index do |point_value, col_idx|
        result << [row_idx, col_idx] if saddle_point?(point_value, row_idx, col_idx)
      end
    end
  end

  private

  def saddle_point?(value, row_idx, col_idx)
    value >= rows[row_idx].max && value <= columns[col_idx].min
  end
end
