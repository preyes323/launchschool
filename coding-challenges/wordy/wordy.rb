class WordProblem
  OPERANDS = { 'plus' => '+', 'minus' => '-',
                'divided' => '/', 'multiplied' => '*' }

  attr_reader :operands, :numbers

  def initialize question
    @numbers = question.scan(/-?\d+/).map(&:to_i)
    @operands = question.scan(/plus|minus|divided|multiplied/)

    raise ArgumentError, "Question not recognized" if @numbers.empty? || @operands.empty?
  end

  def answer
    result = @numbers.first

    @operands.each_with_index do |operand, idx|
      result = result.send OPERANDS[operand], @numbers[idx + 1]
    end

    result
  end
end
