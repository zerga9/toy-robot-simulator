# frozen_string_literal: true

require_relative 'usage_text'

module ToyRobotSimulator
  class CLI
    def initialize(args)
      @args = args
      @parser = CommandParser.new
      @simulator = Simulator.new
    end

    def run
      print_usage if @args.empty?

      create_reader.read do |line|
        cmd = @parser.parse(line)
        break if cmd && cmd[:command] == :exit

        @simulator.execute(cmd)
      end
    end

    private

    def print_usage
      puts USAGE_TEXT
    end

    def create_reader
      @args.empty? ? Readers::StdinReader.new : Readers::FileReader.new(@args[0])
    end
  end
end
