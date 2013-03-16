module RobotanksBot
  class Bot
    include Celluloid
    attr_accessor :writer, :reader

    def initialize(socket)
      @me = nil
      @socket = socket
      async.wait_for_my_messages

      @turning = false
      @moving = false
    end

    def logger
      RobotanksBot.logger
    end

    def run
      logger.info "bots runned"
      writer.write "{\"role\":\"bot\"}\n"
      next_tick
    end

    def next_tick
      logger.info "tick"
      after(0.1) do
        process_ai
        next_tick
      end
    end

    def process_ai
      move(1) unless @moving
      turn_angle(180000000) unless @turning
      fire if rand(10) == 2
    end

    def turn_angle(angle)
      send_to_server({:turn_angle => angle})
      @turning = true
    end

    def move(speed)
      send_to_server({:move => speed})
      @moving = true
    end

    def fire
      send_to_server({:fire => true})
    end

    def send_to_server(value)
      writer.write(MultiJson.dump(value) + "\n")
    end

    def wait_for_my_messages
      loop do
        message = receive do |msg|
          logger.info "receive message #{msg}"
          params = MultiJson.load(msg, :symbolize_keys => true)
          handle params
        end
      end
    end

    def handle params
      params.each do |key, value|
        send(key, value)
      end
    end

    #{"you":{"id":1}}}
    def you(value)
      @me = value
    end

    def map(value)
      @map = Map.new(value)
    end

    def bots(value)
      #values.each do |value|
        #add_bot value
      #end
    end

    def add_bot(value)
      #@bots[value[:id]] = Bot.new(value) unless @bots[value[:id]]
    end

    def bullets(value)
    end

  end
end
