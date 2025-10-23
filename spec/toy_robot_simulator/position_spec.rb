require 'spec_helper'

RSpec.describe ToyRobotSimulator::Position do
  describe '#initialize' do
    it 'creates a position with x and y coordinates' do
      position = described_class.new(2, 3)
      expect(position.x).to eq(2)
      expect(position.y).to eq(3)
    end
  end

  describe '#move' do
    let(:position) { described_class.new(2, 2) }

    context 'when moving NORTH' do
      it 'returns new position with y incremented by 1' do
        new_position = position.move(ToyRobotSimulator::Direction::NORTH)
        expect(new_position.x).to eq(2)
        expect(new_position.y).to eq(3)
      end

      it 'does not modify original position' do
        position.move(ToyRobotSimulator::Direction::NORTH)
        expect(position.x).to eq(2)
        expect(position.y).to eq(2)
      end
    end

    context 'when moving EAST' do
      it 'returns new position with x incremented by 1' do
        new_position = position.move(ToyRobotSimulator::Direction::EAST)
        expect(new_position.x).to eq(3)
        expect(new_position.y).to eq(2)
      end
    end

    context 'when moving SOUTH' do
      it 'returns new position with y decremented by 1' do
        new_position = position.move(ToyRobotSimulator::Direction::SOUTH)
        expect(new_position.x).to eq(2)
        expect(new_position.y).to eq(1)
      end
    end

    context 'when moving WEST' do
      it 'returns new position with x decremented by 1' do
        new_position = position.move(ToyRobotSimulator::Direction::WEST)
        expect(new_position.x).to eq(1)
        expect(new_position.y).to eq(2)
      end
    end

    context 'with invalid direction' do
      it 'returns the same position for nil direction' do
        new_position = position.move(nil)
        expect(new_position).to eq(position)
      end

      it 'returns the same position for invalid symbol' do
        new_position = position.move(:invalid)
        expect(new_position).to eq(position)
      end
    end

    context 'edge cases' do
      it 'moves from (0,0) NORTH to (0,1)' do
        pos = described_class.new(0, 0)
        new_pos = pos.move(ToyRobotSimulator::Direction::NORTH)
        expect(new_pos.x).to eq(0)
        expect(new_pos.y).to eq(1)
      end

      it 'moves from (0,0) SOUTH to (0,-1)' do
        pos = described_class.new(0, 0)
        new_pos = pos.move(ToyRobotSimulator::Direction::SOUTH)
        expect(new_pos.x).to eq(0)
        expect(new_pos.y).to eq(-1)
      end
    end
  end
end
