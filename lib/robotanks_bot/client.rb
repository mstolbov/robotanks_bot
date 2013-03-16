require 'socket'

class RobotanksBot::Client

  def initialize(host, port)
    @socket = TCPSocket.new host, port
  end

  def send(msg)
    @socket.puts msg
  end

  def respond
    @socket.recv(2048)
  end

  def subscribe
    while s = @socket.gets
      yield s
    end
  end

  def close
    @socket.close
  end

end
