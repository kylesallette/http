require 'simplecov'
SimpleCov.start do
 add_filter "/test/"
end
require 'faraday'
require 'minitest/pride'
require 'minitest/autorun'
require 'pry'

class ServerTest < Minitest::Test

  ROOT_RESPONSE =   "<html><head></head><body><pre>\n    Verb: GET\n    Path: /\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  HELLO_RESPONSE =  "<html><head></head><body>Hello World 1\n<pre>\n    Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  HELLO_RESPONSE2 = "<html><head></head><body>Hello World 2\n<pre>\n    Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  HELLO_RESPONSE3 = "<html><head></head><body>Hello World 3\n<pre>\n    Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  HELLO_RESPONSE4 = "<html><head></head><body>Hello World 4\n<pre>\n    Verb: GET\n    Path: /hello\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  DATETIME =   "<html><head></head><body>#{Time.now.strftime("%l:%M%p on %A, %^B %-d, %Y ")}\n<pre>\n    Verb: GET\n    Path: /datetime\n    Protocol: HTTP/1.1\n    Host:  Faraday v0.9.2\n    Port: \n    Origin:  Faraday v0.9.2\n    Accept: */*\n    </pre></body></html>"
  NEW_GAME =   "<html><head></head><body>Good Luck!</body></html>"
  GAME_RESPONSE = "<html><head></head><body>you have made 0 guesses and you haven't guessed anything. Can't tell you how low or how high. .</body></html>"
  GAME_GUESS =  "<html><head></head><body><pre>\n    http/1.1 302 Found\n    Location: http://Faraday v0.9.2:/game\n    date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}\n    server: ruby\n    content-type: text/html; charset=iso-8859-1\n    content-length: 39\n    </pre></body></html>"

  def self.test_order
   :alpha
  end

  def test_a_new_game_body
    response = Faraday.post "http://127.0.0.1:9292/start_game"

    assert_equal NEW_GAME, response.body
  end

  def test_root_body
    response = Faraday.get "http://127.0.0.1:9292/"

    assert_equal ROOT_RESPONSE, response.body
  end

  def test_hello_counts
    response = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal HELLO_RESPONSE, response.body

    response = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal HELLO_RESPONSE2, response.body

    response = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal HELLO_RESPONSE3, response.body

    response = Faraday.get "http://127.0.0.1:9292/hello"

    assert_equal HELLO_RESPONSE4, response.body
  end

  def test_datetime_body
    response = Faraday.get "http://127.0.0.1:9292/datetime"

    assert_equal DATETIME, response.body
  end

  def test_game_response
    response = Faraday.get "http://127.0.0.1:9292/game"

    assert_equal GAME_RESPONSE, response.body
  end

  def test_get_verb
    response = Faraday.get "http://127.0.0.1:9292"

    assert_equal :get, response.env.method
  end


end
