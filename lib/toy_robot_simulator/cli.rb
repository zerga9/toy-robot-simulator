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
      print_usage if @args.empty?

      create_reader.read do |line|
        cmd = parser.parse(line)
        break if cmd && cmd[:command] == :exit

        simulator.execute(cmd)
      end
    end

    private

    def print_usage
      puts '    ___'
      puts '   |[X]|     TOY ROBOT SIMULATOR'
      puts '   /   \\     ==================='
      puts '  |  O  |'
      puts '  |_____|'
      puts '  |  |  |'
      puts '  |__|__|'
      puts ''
      puts 'Commands:'
      puts '  PLACE X,Y,DIRECTION - Place robot at position (X,Y) facing NORTH/SOUTH/EAST/WEST'
      puts '  MOVE                - Move robot one unit forward'
      puts '  LEFT                - Turn robot 90 degrees counter-clockwise'
      puts '  RIGHT               - Turn robot 90 degrees clockwise'
      puts "  REPORT              - Output robot's current position"
      puts ''
      puts 'Note: The first command must be PLACE. All other commands are ignored until'
      puts '      the robot is placed on the table.'
      puts ''
      puts 'Enter commands (one per line). Type exit or quit to exit.'
      puts ''
    end

    def create_reader
      args.empty? ? Readers::StdinReader.new : Readers::FileReader.new(args[0])
    end
  end
end
