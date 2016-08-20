require 'pry'
module RailFenceCipher
  @direction = 'down'
  @pos = 0
  @height = 0

  def self.encode(plaintext, fence_height)
    @height = fence_height
    generate_fence(plaintext.length)
      .each_with_index { |fence, idx| hide_char fence, plaintext[idx] }
      .transpose
      .map { |line| line.join.gsub('*', '') }
      .join

  end

  def self.generate_fence(length)
    (0...length).map { |_| Array.new(@height) { |_| '*' }}
  end

  def self.hide_char(fence, char)
    fence[@pos] = char
    if @direction == 'down'
      @pos += 1 if @pos + 1 < @height
      @direction = 'up' if @pos + 1 == @height
    end
    if @direction == 'up'
      @pos -= 1 if @pos - 1 > 0
      @direction = 'down' if @pos - 1 == 0
    end
  end
end

# p RailFenceCipher.encode('One rail, only one rail', 1)
