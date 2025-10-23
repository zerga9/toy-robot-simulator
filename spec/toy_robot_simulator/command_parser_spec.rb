require 'spec_helper'

RSpec.describe ToyRobotSimulator::CommandParser do
  describe '.parse' do
    context 'with PLACE commands' do
      it 'parses valid PLACE command with NORTH' do
        result = described_class.parse('PLACE 0,0,NORTH')
        expect(result).to eq({
                               command: :place,
                               x: 0,
                               y: 0,
                               direction: :north
                             })
      end

      it 'parses valid PLACE command with EAST' do
        result = described_class.parse('PLACE 2,3,EAST')
        expect(result).to eq({
                               command: :place,
                               x: 2,
                               y: 3,
                               direction: :east
                             })
      end

      it 'parses valid PLACE command with SOUTH' do
        result = described_class.parse('PLACE 4,4,SOUTH')
        expect(result).to eq({
                               command: :place,
                               x: 4,
                               y: 4,
                               direction: :south
                             })
      end

      it 'parses valid PLACE command with WEST' do
        result = described_class.parse('PLACE 1,2,WEST')
        expect(result).to eq({
                               command: :place,
                               x: 1,
                               y: 2,
                               direction: :west
                             })
      end

      it 'handles lowercase place command' do
        result = described_class.parse('place 0,0,NORTH')
        expect(result).to eq({
                               command: :place,
                               x: 0,
                               y: 0,
                               direction: :north
                             })
      end

      it 'handles mixed case direction' do
        result = described_class.parse('PLACE 0,0,North')
        expect(result).to eq({
                               command: :place,
                               x: 0,
                               y: 0,
                               direction: :north
                             })
      end

      it 'handles extra whitespace' do
        result = described_class.parse('  PLACE   0,0,NORTH  ')
        expect(result).to eq({
                               command: :place,
                               x: 0,
                               y: 0,
                               direction: :north
                             })
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

      it 'returns nil for PLACE with negative coordinates' do
        result = described_class.parse('PLACE -1,0,NORTH')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with non-numeric coordinates' do
        result = described_class.parse('PLACE X,Y,NORTH')
        expect(result).to be_nil
      end

      it 'returns nil for PLACE with spaces in coordinates' do
        result = described_class.parse('PLACE 0, 0, NORTH')
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

      it 'handles lowercase commands' do
        result = described_class.parse('move')
        expect(result).to eq({ command: :move })
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
