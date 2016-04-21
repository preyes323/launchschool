class Anagram
  def initialize word
    @word = word
  end

  def match candidates
    candidates.each_with_object([]) do |candidate, anagrams|
      next if @word.downcase == candidate.downcase
      anagrams << candidate if all_letters_match? candidate.downcase.chars
    end
  end

  def all_letters_match? letters
    @word.downcase.chars.sort == letters.sort
  end
end
