class Time
  def to_s
    strftime('%H:%M')
  end

  def +(other)
    Time.at(to_i + other * 60).strftime('%H:%M')
  end

  def -(other)
    self.+(other * -1)
  end
end

class Clock
  def self.at(hour, min =0)
    @whattime = Time.new(2016, 1, 1, hour, min)
  end
end
