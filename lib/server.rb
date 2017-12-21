require 'pry'
require 'socket'
require './lib/game_server'
require './lib/word_search'


class Server

  attr_reader :tcp_server,
              :request,
              :request_lines,
              :client,
              :shutdown,
              :search_word,
              :game,
              :hello_num

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request = 0
    @request_lines = []
    @client = client
    @shutdown = false
    @search_word = search_word
    @game = game
    @hello_num = 0
  end

  def outputting_diagnostics
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(":")[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines.select { |char| char.include?("Accept:")}.join("")
    accept_1 = accept.split(" ")[1]

  "<pre>
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    Origin: #{host}
    Accept: #{accept_1}
   </pre>"
  end

  def path
    if request_lines[0].split(" ")[1] == "/"
      outputting_diagnostics
    elsif request_lines[0].split(" ")[1] == "/hello"
      hello_world
    elsif request_lines[0].split(" ")[1] == "/datetime"
      time
    elsif request_lines[0].split(" ")[1] == "/shutdown"
      shutdown_server
    elsif request_lines[0].split(" ")[1].include? "/word_search"
      searching_for_word
    elsif request_lines[0].split(" ")[1].include? "/start_game" then request_lines[0].split(" ")[0] == "POST"
      @game = GameServer.new
      @game.start_game
    elsif request_lines[0].split(" ")[0] == "POST" then request_lines[0].split(" ")[1] == "/game"
      @game.checking_what_path(request_lines, client)
    elsif request_lines[0].split(" ")[1] == "/game" then request_lines[0].split(" ")[0] == "GET"
      @game.how_many_guesses
    else
      direct = RedirectResponse.new
      direct.redirect_message(request_lines, client, "404 Not Found")
    end
  end

  def hello_world
    @hello_num += 1
    response = "Hello World"
    response + " " + hello_num.to_s + "\n" + outputting_diagnostics
  end

  def searching_for_word
    @search_word = request_lines[0].split(" ")[1].split("=")[1]
    word = WordSearch.new
    word.word_search(search_word) + "\n" + outputting_diagnostics
  end

  def time
    Time.now.strftime("%l:%M%p on %A, %^B %-d, %Y ") + "\n" + outputting_diagnostics
  end

  def shutdown_server
    total = "Total Requests: #{request}"
    @shutdown = true
    total + "\n" + outputting_diagnostics
  end

  def start
    until @shutdown == true
      @client = tcp_server.accept
      @request_lines = Array.new
      while line = client.gets and !line.chomp.empty?
        @request_lines << line.chomp
      end
      puts "recieved request"
      output = "<html><head></head><body>#{path}</body></html>"
      headers = ["http/1.1 200 ok",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{output.length}\r\n\r\n"].join("\r\n")
        @client.puts headers
        @client.puts output
        @request += 1
        @client.close
      end
    end

end
server = Server.new
server.start
