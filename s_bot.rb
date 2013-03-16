require 'em-websocket'

class MainServer
  attr_accessor :data, :connect
 
  def initialize(host, port)
    @connect = TCPSocket.new host, port
  end
end
 
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 5556) do |ws|
  server = MainServer.new("192.168.30.188", 4444)
  puts "connected"
  server.connect.write "{\"role\":\"bot\"}\n"
 
  timer = EM.add_periodic_timer(0.01) do
    data = server.connect.gets
    #puts "data from server #{data}"
    ws.send data
  end
 
  ws.onmessage do |msg|
    msg = "#{msg}\n"
    puts "msg from client: #{msg}"
    server.connect.write(msg)
  end
 
  ws.onclose do
    puts "WebSocket bot closed"
    EM.cancel_timer timer
  end
end
