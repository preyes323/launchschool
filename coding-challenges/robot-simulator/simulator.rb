class Robot
  BEARINGS = [:north, :east, :south, :west]
  attr_reader :bearing, :coordinates

  def orient(direction)
    BEARINGS.include?(direction) ? @bearing = direction : fail(ArgumentError)
  end

  def turn_right
    orient(get_direction(:right))
  end

  def turn_left
    orient(get_direction(:left))
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def advance
    x, y = coordinates
    case bearing
    when :north then y += 1
    when :east  then x += 1
    when :south then y -= 1
    when :west  then x -= 1
    end
    at(x, y)
  end

  private

  def get_direction(pivot)
    offset = pivot == :right ? 1 : -1
    index = BEARINGS.index(bearing)
    case index
    when 0 then pivot == :right ? BEARINGS[index + offset] : BEARINGS[offset]
    when 1 then BEARINGS[index + offset]
    when 2 then BEARINGS[index + offset]
    when 3 then pivot == :left ? BEARINGS[index + offset] : BEARINGS[0]
    end
  end
end

class Simulator
  COMMANDS = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }

  def instructions(commands)
    commands.split('').map { |command| COMMANDS[command] }
  end

  def place(robot, opts)
    robot.at(opts[:x], opts[:y])
    robot.orient(opts[:direction])
  end

  def evaluate(robot, commands)
    instructions(commands).each { |command| robot.send(command) }
  end
end
