require 'minitest/autorun'
require_relative 'prs_oo'

class PRSTest < Minitest::Test
  def test_new_player
    assert_equal 'Paolo', Player.new('Paolo').name
  end

  def test_new_player_is_empty
    assert_equal 'NO_NAME', Player.new.name
  end

  def test_valid_choice
    assert_equal 'Spock', Move.new(:k)
  end

  def test_invalid_choice

  end

  def test_valid_player_choice
  end

  def test_invalid_player_choice
  end

  def test_compare_move_winning_rock_1
  end

  def test_compare_move_winning_rock_2
  end

  def test_compare_move_winning_paper_1
  end

  def test_compare_move_winning_paper_2
  end

  def test_compare_move_winning_scissors_1
  end

  def test_compare_move_winning_scissors_2
  end

  def test_compare_move_winning_spock_1
  end

  def test_compare_move_winning_spock_2
  end

  def test_compare_move_winning_lizard_1
  end

  def test_compare_move_winning_lizard_2
  end

  def test_winning_message_rock_1
  end

  def test_winning_message_rock_2
  end

  def test_winning_message_paper_1
  end

  def test_winning_message_paper_2
  end

  def test_winning_message_scissors_1
  end

  def test_winning_message_scissors_2
  end

  def test_winning_message_spock_1
  end

  def test_winning_message_spock_2
  end

  def test_winning_message_lizard_1
  end

  def test_winning_message_lizard_2
  end
end
