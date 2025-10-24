require 'spec_helper'

RSpec.describe ToyRobotSimulator::CommandParser do
  let(:parser) { described_class.new }

  describe '#parse' do
    context 'with PLACE commands' do
      it 'parses all valid directions' do
        north = parser.parse('PLACE 0,0,NORTH')
        expect(north[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)

        east = parser.parse('PLACE 0,0,EAST')
        expect(east[:direction]).to eq(ToyRobotSimulator::Direction::EAST)

        south = parser.parse('PLACE 0,0,SOUTH')
        expect(south[:direction]).to eq(ToyRobotSimulator::Direction::SOUTH)

        west = parser.parse('PLACE 0,0,WEST')
        expect(west[:direction]).to eq(ToyRobotSimulator::Direction::WEST)
      end

      it 'handles lowercase place command' do
        result = parser.parse('place 1,2,east')
        expect(result[:command]).to eq(:place)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::EAST)
      end

      it 'handles mixed case direction' do
        result = parser.parse('PLACE 0,0,North')
        expect(result[:command]).to eq(:place)
        expect(result[:x]).to eq(0)
        expect(result[:y]).to eq(0)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)
      end

      it 'handles extra whitespace' do
        result = parser.parse('  PLACE   0,0,NORTH  ')
        expect(result[:command]).to eq(:place)
        expect(result[:x]).to eq(0)
        expect(result[:y]).to eq(0)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)
      end
    end

    context 'with invalid PLACE commands' do
      it 'returns nil for PLACE without arguments' do
        result = parser.parse('PLACE')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with invalid direction' do
        result = parser.parse('PLACE 0,0,INVALID')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with missing coordinate' do
        result = parser.parse('PLACE 0,NORTH')
        expect(result).to be_nil
      end
    end

    context 'with other commands' do
      it 'parses MOVE command' do
        result = parser.parse('MOVE')
        expect(result).to eq({ command: :move })
      end

      it 'parses LEFT command' do
        result = parser.parse('LEFT')
        expect(result).to eq({ command: :left })
      end

      it 'parses RIGHT command' do
        result = parser.parse('RIGHT')
        expect(result).to eq({ command: :right })
      end

      it 'parses REPORT command' do
        result = parser.parse('REPORT')
        expect(result).to eq({ command: :report })
      end

      it 'is case insensitive' do
        expect(parser.parse('move')).to eq({ command: :move })
        expect(parser.parse('MoVe')).to eq({ command: :move })
      end

      it 'handles lowercase commands' do
        result = parser.parse('move')
        expect(result).to eq({ command: :move })
      end

      it 'handles whitespace around commands' do
        expect(parser.parse('  MOVE  ')).to eq({ command: :move })
        expect(parser.parse("\tLEFT\n")).to eq({ command: :left })
      end
    end

    context 'with invalid input' do
      it 'returns nil for nil input' do
        result = parser.parse(nil)
        expect(result).to be_nil
      end

      it 'returns nil for empty string' do
        result = parser.parse('')
        expect(result).to be_nil
      end

      it 'returns nil for whitespace only' do
        result = parser.parse('   ')
        expect(result).to be_nil
      end
    end
  end
end
