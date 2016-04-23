## Original code challenge version
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

## Live challenge session version
class Anagram
  def initialize word
    @word = word
    @word_letters = to_letters_hash word
  end

  def match candidates
    candidates.select do |candidate|
      next if @word.downcase == candidate.downcase
      @word_letters == to_letters_hash(candidate)
    end
  end

  def to_letters_hash word
    word.downcase.chars.each_with_object({}) do |letter, collection|
      collection[letter] ||= 0
      collection[letter] += 1
    end
  end
end
