require 'pry'
require 'socket'


class Server

  attr_reader :tcp_server,
              :request,
              :request_lines,
              :client

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request = 0
    @request_lines = []
    @client = client
  end

  def outputting_diagnostics
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(":")[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines[6].split(":")[1].gsub(" ", "")
    binding.pry

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
#    if request_lines[0].split(" ")[1].include?("/")
#      outputting_diagnostics
#    elsif request_lines[0].split(" ")[1].include?("/Hello")
#      hello_world
     if request_lines[0].split(" ")[1].include?("/datetime")
        Time.now.strftime("%d/%m/%Y %H:%M")

    end
  end

#  def hello_world

#    response = "Hello World"
#    output = "<html><head></head><body>#{response + " " + request.to_s}</body></html>"
#    @client.puts output
#    @request += 1
#  end


  def headers
    loop do
    @client = tcp_server.accept
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
