# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe ToyRobotSimulator::Readers::StdinReader do
  describe '#read' do
    around do |example|
      original_stdin = $stdin
      example.run
      $stdin = original_stdin
    end

    it 'yields each line from stdin' do
      $stdin = StringIO.new("PLACE 0,0,NORTH\nMOVE\nREPORT\n")

      reader = described_class.new
      lines = []
      reader.read { |line| lines << line.chomp }

      expect(lines).to eq(['PLACE 0,0,NORTH', 'MOVE', 'REPORT'])
    end

    it 'handles empty input' do
      $stdin = StringIO.new('')

      reader = described_class.new
      lines = []
      reader.read { |line| lines << line }

      expect(lines).to be_empty
    end

    it 'handles lines with whitespace' do
      $stdin = StringIO.new("  PLACE 0,0,NORTH  \n\t\nMOVE\n")

      reader = described_class.new
      lines = []
      reader.read { |line| lines << line.chomp }

      expect(lines).to eq(['  PLACE 0,0,NORTH  ', "\t", 'MOVE'])
    end
  end
end
