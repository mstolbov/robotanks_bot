class RobotanksBot::ClientReader
  include Celluloid
  include Celluloid::IO

  def initialize(socket, bot)
    @bot = bot
    @socket = socket
    async.run
  end

  def run
    loop do
      @bot.mailbox << readline
    end
  end

  def readline
    line = ""
    while char = @socket.read(1)
      return line.gsub("\r", "") if char == $/
      line << char
    end
  end

end
