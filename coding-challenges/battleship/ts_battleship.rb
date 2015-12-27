require 'minitest/spec'
require 'minitest/autorun'
require_relative 'battleship'

describe Player do
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  before do
    @human_player = Human.new
    @computer_player = Computer.new
  end

  describe 'when asked for a human player name' do
    it 'must be NO_NAME' do
      @human_player.name.must_equal 'NO_NAME'
    end

    it 'must be equal to initialized name' do
      name_provided = 'Paolo'
      Player.new('Paolo').name.must_equal name_provided
    end

    it 'must be equal to the set name' do
      set_name = 'Paolo'
      @human_player.name = set_name
      @human_player.name.must_equal set_name
    end
  end

  describe 'when setting a computer player name' do
    it 'must be included in NAMES choices' do
      NAMES.must_include @computer_player.name
    end
  end
end

describe Ship do
  describe 'when creating a new ship' do
    it 'must return true if ship type set is valid' do

    end

    it "must return 'invalid ship type' if ship is not in SHIPS" do
    end

    it 'must have 1 hitpoint if destroyer' do
      @ship.new('destroyer').hitpoints.must_equal 1
    end

    it 'must have 2 hitpoints if cruiser' do
    end

    it 'must have 3 hitpoints if battleship' do
    end
  end
end
