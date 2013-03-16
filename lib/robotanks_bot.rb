require "robotanks_bot/version"
require 'celluloid'
require 'celluloid/io'
require 'multi_json'

module RobotanksBot
  autoload :ClientReader, 'robotanks_bot/client_reader'
  autoload :ClientWriter, 'robotanks_bot/client_writer'
  autoload :AI, 'robotanks_bot/ai'
  autoload :Bot, 'robotanks_bot/bot'
  autoload :Connect, 'robotanks_bot/connect'
  autoload :Map, 'robotanks_bot/map'

  def self.run
    host = "192.168.30.188"
    port = 4444

    socket = Connect.connect host, port
    bot = Bot.new socket
    bot.reader = ClientReader.new socket, bot
    bot.writer = ClientWriter.new socket, bot
    bot.run
  end
end
