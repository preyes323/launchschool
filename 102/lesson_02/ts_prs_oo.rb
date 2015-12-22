require 'minitest/spec'
require 'minitest/autorun'
require_relative 'prs_oo'

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

describe Move do
  describe 'when a move is initialized' do
    it 'must return nil if an invalid move is set' do
      Move.new('invalid move').move.must_be_nil
    end

    it 'must return valid move description for rock' do
      Move.new(:r).move.must_equal '[R]ock'
    end

    it 'must return valid move description for paper' do
      Move.new(:p).move.must_equal '[P]aper'
    end

    it 'must return valid move description for scissors' do
      Move.new(:s).move.must_equal '[S]cissors'
    end

    it 'must return valid move description for lizard' do
      Move.new(:l).move.must_equal '[L]izard'
    end

    it 'must return valid move description for spock' do
      Move.new(:k).move.must_equal 'Spoc[k]'
    end
  end
end
