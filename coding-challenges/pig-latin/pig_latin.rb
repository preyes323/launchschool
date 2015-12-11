class PigLatin
  def self.translate(words)
    words.split.map do |word|
      if %w(a e i o u).include?(word[0].downcase)
        word + 'ay'
      elsif %w(sch thr).include?(word[0, 3].downcase)
        word[3, word.length] + word[0, 3] + 'ay'
      elsif 'qu' == word[1, 2].downcase
        word[3, word.length] + word[0, 3] + 'ay'
      elsif %w(ye xe).include?(word[0, 2].downcase)
        word[1, word.length] + word[0] + 'ay'
      elsif %w(yt xr).include?(word[0, 2].downcase)
        word + 'ay'
      elsif %w(ch qu th).include?(word[0,2].downcase)
        word[2, word.length] + word[0, 2] + 'ay'
      else
        word[1, word.length] + word[0] + 'ay'
      end
    end.join(' ')
  end
end
