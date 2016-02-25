class Clock < Time
  def self.at(hours, minutes = nil)
    Clock.new(2016, nil, nil, hours, minutes, nil, nil)
  end

  def to_s
    strftime "%R"
  end

  def +(minutes)
    hours = (self.hour + minutes/60) % 24
    minutes = (self.min + minutes) % 60
    Clock.at(hours, minutes)
  end

  def -(minutes)
    hours = (self.hour - (minutes/60.0).ceil) % 24
    minutes = (self.min - minutes) % 60
    Clock.at(hours, minutes)
  end

  def ==(other)
    self.to_s == other.to_s
  end
end
