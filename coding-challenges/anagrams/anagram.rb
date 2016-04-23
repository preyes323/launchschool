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
