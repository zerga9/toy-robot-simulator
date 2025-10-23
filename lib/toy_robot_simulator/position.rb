# frozen_string_literal: true

module ToyRobotSimulator
  class Position
    attr_reader :x, :y

    DIRECTION_OFFSETS = {
      north: [0, 1],
      east: [1, 0],
      south: [0, -1],
      west: [-1, 0]
    }.freeze

    def initialize(x, y)
      @x = x
      @y = y
    end

    def move(direction)
      offset = DIRECTION_OFFSETS[direction]
      return self unless offset

      Position.new(x + offset[0], y + offset[1])
    end
  end
end
