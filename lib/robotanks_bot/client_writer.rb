class RobotanksBot::ClientWriter
  include Celluloid
  include Celluloid::IO

  attr_reader :socket

  def initialize(socket, bot)
    @bot = bot
    @socket = socket
    async.wait_for_my_messages
  end

  def write msg
    p "write to server: #{msg}"
    @socket.write(msg)
  end

  def wait_for_my_messages
    loop do
      message = receive do |msg|
        p msg
        socket.write msg
      end
    end
  end

end
