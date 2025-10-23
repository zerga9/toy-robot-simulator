# frozen_string_literal: true

module ToyRobotSimulator
  class Simulator
    attr_reader :robot, :table

    def initialize
      @table = Table.new
      @robot = Robot.new(@table)
    end

    def execute(command_hash)
      return if command_hash.nil?

      case command_hash[:command]
      when :place
        place_robot(command_hash[:x], command_hash[:y], command_hash[:direction])
      when :move then robot.move
      when :left then robot.turn_left
      when :right then robot.turn_right
      when :report then execute_report
      end
    end

    private

    def place_robot(x, y, direction)
      position = Position.new(x, y)
      return unless table.valid_position?(position)

      robot.place(position, direction)
    end

    def execute_report
      output = robot.report
      puts output if output
    end
  end
end
