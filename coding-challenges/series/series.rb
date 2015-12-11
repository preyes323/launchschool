class Series

  def initialize(series)
    @series = series.chars.map(&:to_i)
  end

  def slices(slicer)
    fail ArgumentError, 'Slicer length > series' if slicer > @series.length
    @series
      .each_with_index
      .select { |_, idx| idx <= (@series.length - slicer) }
      .map do |_, idx|
        slicer > 1 ? @series[idx..(idx + slicer - 1)] : [@series[idx]]
      end
  end
end
