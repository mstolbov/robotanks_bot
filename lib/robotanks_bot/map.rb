module RobotanksBot
  class Map
    attr_accessor :width, :height

    def initialize(options)
      @width = options[:width]
      @height = options[:height]
    end
  end
end
