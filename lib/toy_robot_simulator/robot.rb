module ToyRobotSimulator
  class Robot
    attr_reader :position, :direction, :table

    def initialize(table = Table.new)
      @table = table
      @position = nil
      @direction = nil
    end

    def place(position, direction)
      @position = position
      @direction = direction
    end

    def placed?
      !position.nil? && !direction.nil?
    end

    def move
      return unless placed?

      new_position = position.move(direction)
      return unless table.valid_position?(new_position)

      @position = new_position
    end

    def turn_left
      return unless placed?

      @direction = direction.turn_left
    end
  end
end
