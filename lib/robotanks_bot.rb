require "robotanks_bot/version"
require 'celluloid'
require 'celluloid/io'
require 'multi_json'
require 'logging'

module RobotanksBot
  HOST = "192.168.30.188"
  PORT = 4444

  autoload :ClientReader, 'robotanks_bot/client_reader'
  autoload :ClientWriter, 'robotanks_bot/client_writer'
  autoload :AI, 'robotanks_bot/ai'
  autoload :Bot, 'robotanks_bot/bot'
  autoload :Connect, 'robotanks_bot/connect'
  autoload :Map, 'robotanks_bot/map'

  def self.run
    @socket = Connect.connect HOST, PORT
    @bot = Bot.new @socket
    @bot.reader = ClientReader.new @socket, @bot
    @bot.writer = ClientWriter.new @socket, @bot
    @bot.run
  end

  def self.restart
    @socket.close
    self.run
  end

  def self.logger
    @logger ||= Logging.logger(STDOUT)
  end
end
