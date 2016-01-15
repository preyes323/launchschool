class InvalidCodonError < StandardError
  def initialize(msg = 'Codon does not exist')
    super
  end
end

class Translation
  AMINO_ACIDS = { 'Methionine' => %w(AUG), 'Phenylalanine' => %w(UUU UUC),
    'Leucine' => %w(UUA UUG), 'Serine' => %w(UCU UCC UCA UCG),
    'Tyrosine' => %w(UAU UAC), 'Cysteine' => %w(UGU UGC),
    'Tryptophan' => %w(UGG), 'STOP' => %w(UAA UAG UGA) }


  def self.of_codon(codon)
    AMINO_ACIDS.each do |name, codons|
      return name if codons.include? codon
    end
    nil
  end

  def self.of_rna(strand)
    result = []
    until strand.empty?
      codon = Translation.of_codon(strand.slice!(0, 3))
      fail InvalidCodonError unless  codon
      codon == 'STOP' ? break : result << codon
    end
    result
  end
end
