# frozen_string_literal: true

module ToyRobotSimulator
  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def move(direction)
      return self unless direction.is_a?(Direction)

      Position.new(x + direction.dir_x, y + direction.dir_y)
    end
  end
end
