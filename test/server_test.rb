require 'faraday'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/server'
require './lib/word_search'
require './lib/game_server'

class ServerTest < Minitest::Test

  def test_it_exists
    server = Server.new

    assert_instance_of Server, server
  end

end
