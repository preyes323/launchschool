class PigLatin
  def self.translate(words)
    words.split.map do |word|
      if word.scan(/\A[aeiou]|((y|x)[^aeiou])/i).empty?
        word << word.slice!(/s?qu|[^aeiou]{1,3}/i)
      end
      word << 'ay'
    end.join(' ')
  end
end
