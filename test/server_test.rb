require 'faraday'
require 'minitest/pride'
require 'minitest/autorun'
require 'pry'

class ServerTest < Minitest::Test

  ROOT_RESPONSE = "<html><head></head><body><pre>\n    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n   </pre></body></html>"
  HELLO_RESPONSE =  "<html><head></head><body>Hello World 1\n<pre>\n    Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n   </pre></body></html>"
  DATETIME =  "<html><head></head><body>#{Time.now.strftime("%l:%M%p on %A, %^B %-d, %Y ")}\n<pre>\n    Verb: GET\n    Path: /datetime\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n   </pre></body></html>"
  SHUTDOWN = "<html><head></head><body>Total Requests: 3\n<pre>\n    Verb: GET\n    Path: /shutdown\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n   </pre></body></html>"
  NEW_GAME = "<html><head></head><body>Good luck!</body></html>"
  GAME_RESPONSE =  "<html><head></head><body>you have made 0 guesses and you haven't guessed anything. Can't tell you how low or how high. .</body></html>"

  def test_root
    response = Faraday.get "http://127.0.0.1:9292/"

    assert_equal ROOT_RESPONSE, response.body
  end

  def test_hello
    response = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal HELLO_RESPONSE, response.body
  end

  def test_datetime
    response = Faraday.get "http://127.0.0.1:9292/datetime"

    assert_equal DATETIME, response.body
  end

  def test_new_game
    response = Faraday.get "http://127.0.0.1:9292/start_game"

    assert_equal NEW_GAME, response.body
  end

  def test_game
    skip
    response = Faraday.get "http://127.0.0.1:9292/game"

    assert_equal GAME_RESPONSE, response.body
  end

  def test_shutdown
    skip
    response = Faraday.get "http://127.0.0.1:9292/shutdown"

    assert_equal SHUTDOWN, response.body
  end



end
