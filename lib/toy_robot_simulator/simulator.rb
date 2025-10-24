# frozen_string_literal: true

module ToyRobotSimulator
  class Simulator
    attr_reader :robot, :table

    def initialize
      @table = Table.new
      @robot = Robot.new(@table)
    end

    def execute(cmd)
      return unless cmd

      case cmd[:command]
      when :place then place_robot(cmd)
      when :move then robot.move
      when :left then robot.turn(:left)
      when :right then robot.turn(:right)
      when :report then execute_report
      end
    end

    private

    def place_robot(cmd)
      position = Position.new(cmd[:x], cmd[:y])
      robot.place(position, cmd[:direction]) if table.valid_position?(position)
    end

    def execute_report
      output = robot.report
      puts output if output
    end
  end
end
