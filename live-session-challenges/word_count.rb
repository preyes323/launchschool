require 'pry'
p = <<-TEXT
Then Almitra spoke again and said, "And what of Marriage, master?"
And he answered saying:
You were born together, and together you shall be forevermore.
You shall be together when white wings of death scatter your days.
Aye, you shall be together even in the silent memory of God.
But let there be spaces in your togetherness,
And let the winds of the heavens dance between you.
Love one another but make not a bond of love:
Let it rather be a moving sea between the shores of your souls.
Fill each other's cup but drink not from one cup.
Give one another of your bread but eat not from the same loaf.
Sing and dance together and be joyous, but let each one of you be alone,
Even as the strings of a lute are alone though they quiver with the same music.
Give your hearts, but not into each other's keeping.
For only the hand of Life can contain your hearts.
And stand together, yet not too near together:
For the pillars of the temple stand apart,
And the oak tree and the cypress grow not in each other's shadow.
TEXT


def word_count(text)
  words_frequency(parse_words(text))
end

def parse_words(text)
  text.split(/[^a-z^'^A-Z]/).reject(&:empty?)
end

def words_frequency(words)
  words.each_with_object(Hash.new(0)) do |word, result|
    if result.keys.map(&:downcase).include? word.downcase
      result[identify_key(result, word)] += 1
    else
      result[word] += 1
    end
  end
end

def identify_key(hash, word)
  return word if word == word.capitalize && hash.keys.include?(word)
  word.downcase
end

p word_count(p)
p word_count(p).values.reduce(:+)
p parse_words(p).size
