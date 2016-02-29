class Clock
  def self.at(hours, minutes = nil)
    @time = Time.new(2016, nil, nil, hours, minutes, nil, nil)
  end

  def to_s
    @time.strftime "%R"
  end

  def +(minutes)
    hours = (@time.hour + minutes/60) % 24
    minutes = (@time.min + minutes) % 60
    Clock.at(hours, minutes)
  end

  def -(minutes)
    hours = (@time.hour - (minutes/60.0).ceil) % 24
    minutes = (@time.min - minutes) % 60
    Clock.at(hours, minutes)
  end

  def ==(other)
    self.to_s == other.to_s
  end
end
