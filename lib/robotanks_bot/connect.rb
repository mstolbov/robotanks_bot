module RobotanksBot
  class Connect
    include ::Celluloid::IO

    def self.connect(host, port)
      TCPSocket.new host, port
    end
  end
end
