class CircularBuffer
  attr_accessor :buffer

  def initialize(buffer_size)
    self.buffer = Array.new(buffer_size)
  end

  def read
    raise BufferEmptyException if buffer.all?(&:nil?)
    self.buffer << nil
    buffer.shift
  end

  def write(element)
    raise BufferFullException if buffer.none?(&:nil?)
    self.buffer[buffer.index(nil)] = element if element
  end

  def write!(element)
    if element
      read unless buffer.any?(&:nil?)
      write(element)
    end
  end

  def clear
    buffer.size.times { read }
  end

  class BufferEmptyException < Exception; end
  class BufferFullException < Exception; end
end
