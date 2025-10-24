module ToyRobotSimulator
  class Direction
    attr_reader :name, :dir_x, :dir_y

    def initialize(name, dir_x, dir_y)
      @name = name
      @dir_x = dir_x
      @dir_y = dir_y
    end

    NORTH = new('NORTH', 0, 1)
    EAST = new('EAST', 1, 0)
    SOUTH = new('SOUTH', 0, -1)
    WEST = new('WEST', -1, 0)

    DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

    def turn(direction)
      offset = direction == :left ? -1 : 1

      idx = DIRECTIONS.index(self)
      DIRECTIONS[(idx + offset) % DIRECTIONS.size]
    end

    def self.from_string(str)
      return nil unless str

      DIRECTIONS.find { |d| d.name == str.upcase }
    end
  end
end
