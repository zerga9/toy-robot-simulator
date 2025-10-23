# frozen_string_literal: true

module ToyRobotSimulator
  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end
  end
end
