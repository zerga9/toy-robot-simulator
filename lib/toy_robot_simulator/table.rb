module ToyRobotSimulator
  class Table
    SIZE = 5

    def valid_position?(position)
      return false if position.nil?

      position.x >= 0 && position.x < SIZE &&
        position.y >= 0 && position.y < SIZE
    end
  end
end
