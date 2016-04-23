class Anagram
  def initialize word
    @word = word
    @word_letters = to_letters word
  end

  def match candidates

    candidates.each_with_object([]) do |candidate, anagrams|
      next if @word.downcase == candidate.downcase
      candidate_letters = to_letters candidate
      anagrams << candidate if all_letters_match? candidate_letters
    end
  end

  def all_letters_match? letters
    @word_letters.keys.all? { |letter| letters[letter] == @word_letters[letter] }
  end

  def to_letters word
    word.downcase.chars.each_with_object({}) do |letter, collection|
      collection[letter] ||= 0
      collection[letter] += 1
    end
  end
end
