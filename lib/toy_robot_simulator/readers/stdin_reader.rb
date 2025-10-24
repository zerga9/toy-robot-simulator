# frozen_string_literal: true

module ToyRobotSimulator
  module Readers
    class StdinReader
      def read(&block)
        $stdin.each_line do |line|
          line = line.chomp
          break if %w[EXIT QUIT].include?(line.upcase)

          block.call(line)
        end
      end
    end
  end
end
