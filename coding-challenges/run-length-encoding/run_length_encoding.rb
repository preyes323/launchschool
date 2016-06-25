module RunLengthEncoding
  def self.encode(input)
    count = 1

    (1..input.length).each_with_object('') do |idx, result|
      if input[idx] == input[idx - 1]
        count += 1
      else
        result << (count > 1 ? "#{count}#{input[idx - 1]}" : input[idx - 1])
        count = 1
      end
    end
  end

  def self.decode(input)
    input.scan(/\d*\D/).map{ |coded| expand coded }.join
  end

  def self.expand(coded)
    count = coded.slice!(/\d+/)
    count ? coded * count.to_i : coded
  end
end
