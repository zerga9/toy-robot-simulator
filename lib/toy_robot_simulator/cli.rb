# frozen_string_literal: true

module ToyRobotSimulator
  class CLI
    attr_reader :simulator, :parser

    def initialize
      @simulator = Simulator.new
      @parser = CommandParser.new
    end

    def run
      create_reader.read do |line|
        simulator.execute(parser.parse(line))
      end
    end

    private

    def create_reader
      ToyRobotSimulator::Readers::StdinReader.new
    end
  end
end
