module ToyRobotSimulator
  class Robot
    DIRECTIONS = %i[north east south west].freeze

    attr_reader :position, :direction, :table

    def initialize(table = Table.new)
      @table = table
      @position = nil
      @direction = nil
    end

    def place(position, direction)
      return unless DIRECTIONS.include?(direction.to_s.downcase.to_sym)

      @position = position
      @direction = direction.to_s.downcase.to_sym
    end

    def placed?
      !@position.nil? && !@direction.nil?
    end

    def move
      return unless placed?

      new_position = position.move(direction)
      return unless table.valid_position?(new_position)

      @position = new_position
    end
  end
end
