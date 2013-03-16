require "robotanks_bot/version"

module RobotanksBot
  autoload :Client, 'robotanks_bot/client'
  autoload :Io, 'robotanks_bot/io'

  def self.run
    host = "192.168.30.188"
    port = 4444
    @connect = Client.new host, port

    @bot = Io.new @connect
  end
end
