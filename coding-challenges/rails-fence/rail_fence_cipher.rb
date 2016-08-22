require 'pry'
module RailFenceCipher # :nodoc:
  def self.encode(plaintext, height)
    pos = generate_rail_positions height
    generate_fence(plaintext.length, height)
      .each_with_index { |fence, idx| fence[pos[idx % (height * 2 - 1)]] = plaintext[idx] }

    binding.pry

  end

  def self.generate_fence(length, height)
    (0...length).map { |_| Array.new(height) { |_| '*' } }
  end

  def self.generate_rail_positions(height)
    pos = Array.new(height * 2 - 1)
    (0...height - 1).each do |idx|
      pos[idx] = idx
      pos[pos.length - 1 - idx] = idx
    end

    pos[height - 1] = height - 1
    pos
  end
end

p RailFenceCipher.encode('XOXOXOXOXOXOXOXOXO', 2)
