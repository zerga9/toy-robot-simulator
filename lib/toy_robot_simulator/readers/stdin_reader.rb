# frozen_string_literal: true

module ToyRobotSimulator
  module Readers
    class StdinReader
      def read(&block)
        $stdin.each_line do |line|
          block.call(line.chomp)
        end
      end
    end
  end
end
