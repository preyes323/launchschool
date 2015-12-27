#----------------------------------------------
# battleship.rb
# BATTLESHIP GAME
#
# Two player game between a human and a computer. The objective is to find
# and destroy all the opposing players ships.
#----------------------------------------------

require 'pry'
require 'colorize'
require 'yaml'

class Player
  attr_reader :name, :move

  def initialize(name = '')
    self.name = name
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def choose; end

  def ships; end

  def position_ships; end
end

class Human < Player

  def choose; end

  def position_ships; end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose; end

  def position_ships; end
end

class Ship
  SHIPS = %w(destroyer, cruiser, battleship)

end
