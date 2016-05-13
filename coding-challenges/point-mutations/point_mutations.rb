class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(new_strand)
    distance = 0
    max_length = [@strand.size, new_strand.size].min - 1

    (0..max_length).count do |idx|
      distance += 1 unless @strand[idx] == new_strand[idx]
    end

    distance
  end
end
