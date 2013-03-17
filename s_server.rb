require 'em-websocket'

class MainServer
  attr_accessor :data, :connect
 
  def initialize(host, port)
    @connect = TCPSocket.new host, port
  end
end
 
 
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 5555) do |ws|
  server = nil
  ws.onopen do |handshake|
    server = MainServer.new("192.168.30.188", 4444)
    server.connect.write "{\"role\":\"observer\"}\n"
    puts "connected"
    ws.send "Hello Client, you connected to #{handshake.path}"
  end
 
  timer = EM.add_periodic_timer(0.01) do
    if server
      data = server.connect.gets
      puts "data from server #{data}"
      ws.send data
    end
  end
 
  ws.onclose do
    puts "WebSocket server closed"
    EM.cancel_timer timer
  end
end
