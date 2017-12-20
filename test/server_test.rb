require 'faraday'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/server.rb'


class ServerTest < Minitest::Test

  def test_it_exists
    server = Server.new

    assert_instance_of Server, server
  end

  def test_something
    conn = Faraday.new(url: "localhost:9292")
    server = Server.new
    expected = conn.get/
     assert_equal expected server.headers
  end
