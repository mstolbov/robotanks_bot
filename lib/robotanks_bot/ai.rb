class RobotanksBot::AI

  def initialize(connect)
    @connent = connect
    send({role: "bot"})
  end

  def send(msg)
    json_msg = MultiJson.dump msg
    @connect.send json_msg
    resp = @connect.respond
    MultiJson.load resp, symbolize_keys: true
  end
end
