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

  describe '#move' do
    context 'when robot is placed' do
      it 'moves north correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), :north)
        robot.move
        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(3)
      end

      it 'moves east correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), :east)
        robot.move
        expect(robot.position.x).to eq(3)
        expect(robot.position.y).to eq(2)
      end

      it 'moves south correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), :south)
        robot.move
        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(1)
      end

      it 'moves west correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), :west)
        robot.move
        expect(robot.position.x).to eq(1)
        expect(robot.position.y).to eq(2)
      end
    end
  end
end
