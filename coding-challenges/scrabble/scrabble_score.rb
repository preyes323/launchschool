class Scrabble # :nodoc:
  CHARACTER_SCORES = { 'AEIOULNRST' => 1, 'DG' => 2,
                       'BCMP' => 3, 'FHVWY' => 4, 'K' => 5,
                       'JX' => 8, 'QZ' => 10 }.freeze

  def initialize(word)
    @word = word.to_s.upcase.gsub(/[^A-Z]/, '')
  end

  def score
    @word.chars.reduce(0) do |total, char|
      total + char_score(char)
    end
  end

  def self.score(word)
    new(word).score
  end

  private

  def char_score(char)
    CHARACTER_SCORES[CHARACTER_SCORES.keys.select { |key| key.include? char }.first]
  end
end
