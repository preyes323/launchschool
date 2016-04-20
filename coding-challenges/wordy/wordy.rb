class WordProblem
  OPERATORS = { 'plus' => '+', 'minus' => '-',
                'divided' => '/', 'multiplied' => '*' }

  attr_reader :operands, :numbers

  def initialize question
    @numbers = question.scan(/-?\d+/).map(&:to_i)
    @operators = question.scan(/plus|minus|divided|multiplied/)

    raise ArgumentError, "Question not recognized" if @numbers.empty? || @operators.empty?
  end

  def answer
    @operators.reduce(@numbers.shift) do |result, (operator, idx)|
      result.send OPERATORS[operator], @numbers.shift
    end
  end
end
