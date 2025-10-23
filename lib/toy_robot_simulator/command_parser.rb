module ToyRobotSimulator
  class CommandParser
    def self.parse(input)
      return nil if input.nil? || input.strip.empty?

      parts = input.strip.split(/\s+/)
      command = parts[0].downcase

      case command
      when 'place'
        parse_place(parts[1])
      else
        { command: command.to_sym }
      end
    end

    def self.parse_place(args)
      return nil unless args

      match = args.match(/^(\d+),(\d+),(NORTH|EAST|SOUTH|WEST)$/i)
      return nil unless match

      {
        command: :place,
        x: match[1].to_i,
        y: match[2].to_i,
        direction: match[3].downcase.to_sym
      }
    end
  end
end
