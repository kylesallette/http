
require 'socket'


class Server

  attr_reader :tcp_server,
              :request,
              :request_lines

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request = 0
    @request_lines = []
  end




  def path
    verb = request_lines[0].split(" ")[0]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(":")[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines[6]
   "<pre>
    Verb:#{verb}
    Path: /
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    Origin: #{host}
   #{accept}
   </pre>"
  end


  def headers
    loop do

    client = tcp_server.accept
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
          client.puts headers
          client.puts output
          @request += 1
          client.close
    end
  end

end

server = Server.new
server.headers
