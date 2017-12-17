
require 'socket'
tcp_server = TCPServer.new(9292)
request = 0
loop do
client = tcp_server.accept

response = "Hello World"
output = "<html><head></head><body>#{response + " " + request.to_s}</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output
request += 1

end
