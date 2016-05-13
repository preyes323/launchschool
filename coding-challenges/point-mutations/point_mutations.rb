class DNA
  def initialize strand
    @strand = strand
  end

  def hamming_distance other
    length = [@strand.size, other.size].min - 1

    (0..length).reduce(0) do |distance, idx|
      @strand[idx] == other[idx] ? distance : distance + 1
    end
  end
end
