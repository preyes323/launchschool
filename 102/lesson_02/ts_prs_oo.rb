require 'minitest/autorun'
require_relative 'prs_oo'

class PRSTest < Minitest::Test
  def test_new_player
    assert 'Paolo', Player.new('Paolo')
  end

  def test_new_player_is_empty
    assert 'NO_NAME', Player.new
  end
end
