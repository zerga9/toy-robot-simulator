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
  end
end
