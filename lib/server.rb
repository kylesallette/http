require 'pry'
require 'socket'


class Server

  attr_reader :tcp_server,
              :request,
              :request_lines,
              :client,
              :shutdown,
              :search_word

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request = 0
    @request_lines = []
    @client = client
    @shutdown = false
    @search_word = search_word
  end

  def outputting_diagnostics
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(":")[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines[6].split(":")[1].gsub(" ", "")

  "<pre>
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    Origin: #{host}
    Accept: #{accept}
   </pre>"
  end

  def path
    if request_lines[0].split(" ")[1] == "/"
      outputting_diagnostics
    elsif request_lines[0].split(" ")[1] == "/hello"
      hello_world
     elsif request_lines[0].split(" ")[1] == "/datetime"
        Time.now.strftime("%l:%M%p on %A, %^B %-d, %Y ")
     elsif request_lines[0].split(" ")[1] == "/shutdown"
       shutdown
     elsif request_lines[0].split(" ")[1].include? "/word_search"
        @search_word = request_lines[0].split(" ")[1].split("=")[1]
        word_search
     end
  end

  def hello_world
    response = "Hello World"
    response + " " + request.to_s
  end

  def word_search
    dic_words = []
    File.readlines("/usr/share/dict/words").each do |words|
      dic_words << words.chomp
    end
    if dic_words.include?(search_word)
      "WORD is a known word"
    else
      "WORD is not a known word"
    end
  end

  def shutdown
    total = "Total Requests: #{request}"
    @shutdown = true
    total
  end

  def headers
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
server.headers
