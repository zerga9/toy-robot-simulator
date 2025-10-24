# frozen_string_literal: true

module ToyRobotSimulator
  class Table
    SIZE = 5

    def valid_position?(position)
      return false if position.nil?

      (0...SIZE).cover?(position.x) && (0...SIZE).cover?(position.y)
    end
  end
end
