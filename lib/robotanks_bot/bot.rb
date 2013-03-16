module RobotanksBot
  class Bot
    include Celluloid
    attr_accessor :writer, :reader

    def initialize(socket)
      @my_id = nil
      @socket = socket
      async.wait_for_my_messages

      @turning = false
      @moving = false
    end

    def run
      "bots runned"
      writer.write "{\"role\":\"bot\"}\n"
      next_tick
    end

    def next_tick
      puts "tick"
      puts "me alive #{@me}" if @me
      after(0.1) do
        process_ai
        next_tick
      end
    end

    def process_ai
      move(1) unless @moving
      turn_angle(180000000) unless @turning
    end

    def turn_angle(angle)
      send_to_server({:turn_angle => angle})
      @turning = true
    end

    def move(speed)
      send_to_server({:move => speed})
      @moving = true
    end

    def send_to_server(value)
      writer.write(MultiJson.dump(value) + "\n")
    end

    def wait_for_my_messages
      loop do
        message = receive do |msg|
          puts msg
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
      @my_id = value[:id]
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

  end
end
