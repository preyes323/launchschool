class Octal
  def initialize(octal)
    @octal = octal =~ /[^0-7]/ ? [0] : octal.chars.map(&:to_i)
  end

  def to_decimal

  end
end
