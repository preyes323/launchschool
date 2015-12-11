class Luhn
  def initialize(id_number)
    @id_number = id_number.to_s.chars.map(&:to_i)
  end

  def addends
    @id_number.reverse.each_with_index.map do |num, idx|        
      if idx.odd?     
        (num * 2) > 9 ? num * 2 - 9 : num * 2
      else
        num
      end
    end.reverse
  end

  def checksum
    addends.reduce(:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(id_number)
    return id_number if Luhn.new(id_number).valid?      
    9.times do |check_digit|
      new_id = id_number.to_s.concat(check_digit.to_s).to_i
      return new_id if Luhn.new(new_id).valid?
    end
  end
end
