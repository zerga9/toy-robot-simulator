# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::CommandParser do
  subject(:parser) { described_class.new }

  describe '#parse' do
    context 'with PLACE commands' do
      %w[NORTH EAST SOUTH WEST].each do |dir|
        it "parses #{dir} direction" do
          result = parser.parse("PLACE 0,0,#{dir}")
          expect(result[:direction]).to eq(ToyRobotSimulator::Direction.const_get(dir))
        end
      end

      it 'is case insensitive' do
        result = parser.parse('place 1,2,east')
        expect(result[:command]).to eq(:place)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::EAST)
      end

      it 'handles extra whitespace' do
        result = parser.parse('  PLACE   0,0,NORTH  ')
        expect(result).to include(command: :place, x: 0, y: 0, direction: ToyRobotSimulator::Direction::NORTH)
      end
    end

    context 'with invalid PLACE commands' do
      {
        'without arguments' => 'PLACE',
        'with invalid direction' => 'PLACE 0,0,INVALID',
        'with missing coordinate' => 'PLACE 0,NORTH'
      }.each do |description, input|
        it "returns nil for PLACE #{description}" do
          expect(parser.parse(input)).to be_nil
        end
      end
    end

    context 'with simple commands' do
      {
        MOVE: :move,
        LEFT: :left,
        RIGHT: :right,
        REPORT: :report
      }.each do |input, command|
        it "parses #{input} command" do
          expect(parser.parse(input.to_s)).to eq({ command: command })
        end
      end

      it 'is case insensitive' do
        expect(parser.parse('move')).to eq({ command: :move })
        expect(parser.parse('MoVe')).to eq({ command: :move })
      end

      it 'handles whitespace' do
        expect(parser.parse('  MOVE  ')).to eq({ command: :move })
        expect(parser.parse("\tLEFT\n")).to eq({ command: :left })
      end
    end

    context 'with invalid input' do
      [nil, '', '   '].each do |input|
        it "returns nil for #{input.inspect}" do
          expect(parser.parse(input)).to be_nil
        end
      end
    end
  end
end
