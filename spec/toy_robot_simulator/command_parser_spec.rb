require 'spec_helper'

RSpec.describe ToyRobotSimulator::CommandParser do
  describe '.parse' do
    context 'with PLACE commands' do
      it 'parses all valid directions' do
        north = described_class.parse('PLACE 0,0,NORTH')
        expect(north[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)

        east = described_class.parse('PLACE 0,0,EAST')
        expect(east[:direction]).to eq(ToyRobotSimulator::Direction::EAST)

        south = described_class.parse('PLACE 0,0,SOUTH')
        expect(south[:direction]).to eq(ToyRobotSimulator::Direction::SOUTH)

        west = described_class.parse('PLACE 0,0,WEST')
        expect(west[:direction]).to eq(ToyRobotSimulator::Direction::WEST)
      end

      it 'handles lowercase place command' do
        result = described_class.parse('place 1,2,east')
        expect(result[:command]).to eq(:place)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::EAST)
      end

      it 'handles mixed case direction' do
        result = described_class.parse('PLACE 0,0,North')
        expect(result[:command]).to eq(:place)
        expect(result[:x]).to eq(0)
        expect(result[:y]).to eq(0)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)
      end

      it 'handles extra whitespace' do
        result = described_class.parse('  PLACE   0,0,NORTH  ')
        expect(result[:command]).to eq(:place)
        expect(result[:x]).to eq(0)
        expect(result[:y]).to eq(0)
        expect(result[:direction]).to eq(ToyRobotSimulator::Direction::NORTH)
      end
    end

    context 'with invalid PLACE commands' do
      it 'returns nil for PLACE without arguments' do
        result = described_class.parse('PLACE')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with invalid direction' do
        result = described_class.parse('PLACE 0,0,INVALID')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with missing coordinate' do
        result = described_class.parse('PLACE 0,NORTH')
        expect(result).to be_nil
      end
    end

    context 'with other commands' do
      it 'parses MOVE command' do
        result = described_class.parse('MOVE')
        expect(result).to eq({ command: :move })
      end

      it 'parses LEFT command' do
        result = described_class.parse('LEFT')
        expect(result).to eq({ command: :left })
      end

      it 'parses RIGHT command' do
        result = described_class.parse('RIGHT')
        expect(result).to eq({ command: :right })
      end

      it 'parses REPORT command' do
        result = described_class.parse('REPORT')
        expect(result).to eq({ command: :report })
      end

      it 'is case insensitive' do
        expect(described_class.parse('move')).to eq({ command: :move })
        expect(described_class.parse('MoVe')).to eq({ command: :move })
      end

      it 'handles lowercase commands' do
        result = described_class.parse('move')
        expect(result).to eq({ command: :move })
      end

      it 'handles whitespace around commands' do
        expect(described_class.parse('  MOVE  ')).to eq({ command: :move })
        expect(described_class.parse("\tLEFT\n")).to eq({ command: :left })
      end
    end

    context 'with invalid input' do
      it 'returns nil for nil input' do
        result = described_class.parse(nil)
        expect(result).to be_nil
      end

      it 'returns nil for empty string' do
        result = described_class.parse('')
        expect(result).to be_nil
      end

      it 'returns nil for whitespace only' do
        result = described_class.parse('   ')
        expect(result).to be_nil
      end
    end
  end
end
