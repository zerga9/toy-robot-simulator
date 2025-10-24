# frozen_string_literal: true

module ToyRobotSimulator
  class CommandParser
    SIMPLE_COMMANDS = {
      'MOVE' => { command: :move },
      'LEFT' => { command: :left },
      'RIGHT' => { command: :right },
      'REPORT' => { command: :report },
      'EXIT' => { command: :exit },
      'QUIT' => { command: :exit }
    }.freeze

    def parse(line)
      return nil if line.nil? || line.strip.empty?

      line = line.strip.upcase

      parse_place(line) || SIMPLE_COMMANDS[line]
    end

    private

    def parse_place(line)
      return nil unless line.start_with?('PLACE ')

      params = line.sub('PLACE ', '').strip
      return nil if params.empty?

      x, y, direction = extract_place_params(params)
      return nil unless direction

      { command: :place, x: x, y: y, direction: direction }
    end

    def extract_place_params(params)
      place_params = params.split(',').map(&:strip)
      return [nil, nil, nil] unless place_params.size == 3

      x = place_params[0].to_i
      y = place_params[1].to_i
      direction = Direction.from_string(place_params[2])

      [x, y, direction]
    end
  end
end
