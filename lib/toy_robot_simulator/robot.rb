# frozen_string_literal: true

module ToyRobotSimulator
  class Robot
    attr_reader :position, :direction, :table

    def initialize(table = Table.new)
      @position = nil
      @direction = nil
      @table = table
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

    def turn(rotation)
      return unless placed?

      @direction = @direction.turn(rotation)
    end

    def report
      return nil unless placed?

      "#{position.x},#{position.y},#{direction.name}"
    end
  end
end
