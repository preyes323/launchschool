require 'pry'

class Matrix
  attr_reader :cells

  def initialize(cell_values)
    @cells = cell_values.split("\n").map(&:split).map do |row|
      row.map(&:to_i)
    end
  end

  def rows
    cells
  end

  def columns
    cells.transpose
  end

  def saddle_points
    cells.each_with_index.each_with_object([]) do |(row, row_idx), result|
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
