require 'date'

class Meetup
  attr_reader :month, :year
  TEENTHS = (13..19).to_a

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    case schedule
    when :teenth
      weekday_instances(weekday)
        .select { |_day| TEENTHS.include? _day.day }.first
    when :first then weekday_instances(weekday).first
    when :second then weekday_instances(weekday)[1]
    when :third then weekday_instances(weekday)[2]
    when :fourth then weekday_instances(weekday)[3]
    when :last then weekday_instances(weekday).last
    end
  end

  private

  def weekday_instances(weekday)
    day = (weekday.to_s + '?').to_sym
    Date.new(year, month).step(Date.new(year, month, -1)).select(&day)
  end
end
