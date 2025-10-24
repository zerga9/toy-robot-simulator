# frozen_string_literal: true

module ToyRobotSimulator
  module Readers
    class FileReader
      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end

      def read(&block)
        File.foreach(filename, &block)
      rescue Errno::ENOENT
        warn "Error: File '#{filename}' not found"
      rescue Errno::EACCES
        warn "Error: Permission denied reading '#{filename}'"
      end
    end
  end
end
