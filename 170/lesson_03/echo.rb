require 'socket'
require 'pry'

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept

  request_line = client.gets.split

  binding.pry
  http_method = request_line[0]

  if request_line[1] =~ /\?/
    path, params = request_line[1].split('?')
    params = params.split('&').map { |param| param.split('=') }.to_h
  else
    path = request_line[1]
  end

  client.puts "#{path}, #{params}, #{http_method}"
  client.close
end
