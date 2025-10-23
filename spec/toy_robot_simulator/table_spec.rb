require 'spec_helper'

RSpec.describe ToyRobotSimulator::Table do
  subject(:table) { described_class.new }

  describe '#valid_position?' do
    let(:table) { described_class.new }

    context 'with valid positions' do
      it 'returns true for corner positions' do
        expect(table.valid_position?(ToyRobotSimulator::Position.new(0, 0))).to be true
        expect(table.valid_position?(ToyRobotSimulator::Position.new(4, 4))).to be true
      end

      it 'returns true for middle positions' do
        expect(table.valid_position?(ToyRobotSimulator::Position.new(2, 3))).to be true
      end
    end

    context 'with invalid positions' do
      it 'returns false for negative coordinates' do
        expect(table.valid_position?(ToyRobotSimulator::Position.new(-1, 0))).to be false
        expect(table.valid_position?(ToyRobotSimulator::Position.new(0, -1))).to be false
        expect(table.valid_position?(ToyRobotSimulator::Position.new(-1, -1))).to be false
      end

      it 'returns false for coordinates at or beyond boundaries' do
        expect(table.valid_position?(ToyRobotSimulator::Position.new(5, 0))).to be false
        expect(table.valid_position?(ToyRobotSimulator::Position.new(0, 5))).to be false
        expect(table.valid_position?(ToyRobotSimulator::Position.new(5, 5))).to be false
      end

      it 'returns false for coordinates far beyond boundaries' do
        expect(table.valid_position?(ToyRobotSimulator::Position.new(10, 0))).to be false
        expect(table.valid_position?(ToyRobotSimulator::Position.new(0, 10))).to be false
      end

      it 'returns false for nil position' do
        expect(table.valid_position?(nil)).to be false
      end
    end
  end
end
