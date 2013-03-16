class RobotanksBot::Io

  def initialize(connect)
    @connent = connect
    send("bot")
  end

  def send(msg)
    @connect.send msg
    resp = @connect.respond
    #MultiJson.load resp, symbolize_keys: true
  #rescue MultiJson::DecodeError
    #resp
  end
end
