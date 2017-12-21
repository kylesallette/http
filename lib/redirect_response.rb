class RedirectResponse


  def redirect_message(request_lines, client)
    host = request_lines[1].split(":")[1]
    output = "<html><head></head><body></body></html>"
    "<pre>
    http/1.1 302 found
    Location: #{host}:9292/game
    date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}
    server: ruby
    content-type: text/html; charset=iso-8859-1
    content-length: #{output.length}
    </pre>"
  end

end
