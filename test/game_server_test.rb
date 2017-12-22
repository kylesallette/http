require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_server'


class GamerServerTest < Minitest::Test

  def test_it_exists
    game = GameServer.new

    assert_instance_of GameServer, game
  end


  def test_guesses_start_empty
    game = GameServer.new

    assert_equal [], game.guesses
  end

end
