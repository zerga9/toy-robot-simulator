# frozen_string_literal: true

module ToyRobotSimulator
  class CLI
    attr_reader :args, :parser, :simulator

    def initialize(args)
      @args = args
      @parser = CommandParser.new
      @simulator = Simulator.new
    end

    def run
      create_reader.read do |line|
        simulator.execute(parser.parse(line))
      end
    end

    private

    def create_reader
      args.empty? ? Readers::StdinReader.new : Readers::FileReader.new(args[0])
    end
  end
end
