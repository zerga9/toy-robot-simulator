require 'spec_helper'

RSpec.describe ToyRobotSimulator::Robot do
  let(:robot) { described_class.new }
  let(:position) { ToyRobotSimulator::Position.new(0, 0) }
  let(:direction) { :north }

  describe '#initialize' do
    it 'starts in an unplaced state' do
      expect(robot.position).to be_nil
      expect(robot.direction).to be_nil
    end
  end

  describe '#place' do
    it 'places the robot at the given position and direction' do
      robot.place(position, direction)
      expect(robot.position).to eq(position)
      expect(robot.direction).to eq(direction)
    end
  end

  describe '#placed?' do
    context 'when robot is not placed' do
      it 'returns false' do
        expect(robot.placed?).to be false
      end
    end

    context 'when robot is placed' do
      before do
        robot.place(position, direction)
      end

      it 'returns true' do
        expect(robot.placed?).to be true
      end
    end
  end
end
