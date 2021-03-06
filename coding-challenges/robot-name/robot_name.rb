class Robot # :nodoc:
  @@names = []
  CHARS = 2
  NUMBERS = 3

  def initialize
    @name = generate
  end

  def reset
    @name = nil
  end

  def name
    @name ||= generate
  end

  private

  def generate
    name = chars_component + numbers_component while @@names.include? name
    @@names << name
    name
  end

  def chars_component
    chars = ''
    chars += [*'A'..'Z'].sample(random: rand) until chars.size == CHARS
    chars
  end

  def numbers_component
    numbers = ''
    numbers += [*'0'..'9'].sample(random: rand) until numbers.size == NUMBERS
    numbers
  end
end
