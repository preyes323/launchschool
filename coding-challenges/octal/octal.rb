class Octal
  def initialize(octal)
    @octal = octal =~ /[^0-7]/ ? [0] : octal.chars.map(&:to_i).reverse
  end

  def to_decimal
    @octal
      .each_with_index
      .inject(0) { |decimal, (value, idx)| decimal + value * 8 ** idx }
  end
end
