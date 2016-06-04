class House
  def self.recite
    lines = House.new.send(:pieces)

    rhyme = lines.reverse.each_with_object([]) do |line, stanzas|
      if @phrase
        @phrase.gsub!('This is ','').gsub!('.', '')
        @phrase = "This is " + [line.first, [line.last,  @phrase].join(' ')].join("\n")
      else
        @phrase ||= ['This is', line.first].join(' ')
      end

      @phrase << '.'
      stanzas << @phrase.dup
    end

    rhyme.join("\n\n") << "\n"
  end

  private

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
