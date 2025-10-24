# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::Robot do
  let(:robot) { described_class.new }
  let(:position) { ToyRobotSimulator::Position.new(0, 0) }
  let(:direction) { ToyRobotSimulator::Direction::NORTH }

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
        robot.place(ToyRobotSimulator::Position.new(2, 2), ToyRobotSimulator::Direction::NORTH)
        robot.move
        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(3)
      end

      it 'moves east correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), ToyRobotSimulator::Direction::EAST)
        robot.move
        expect(robot.position.x).to eq(3)
        expect(robot.position.y).to eq(2)
      end

      it 'moves south correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), ToyRobotSimulator::Direction::SOUTH)
        robot.move
        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(1)
      end

      it 'moves west correctly' do
        robot.place(ToyRobotSimulator::Position.new(2, 2), ToyRobotSimulator::Direction::WEST)
        robot.move
        expect(robot.position.x).to eq(1)
        expect(robot.position.y).to eq(2)
      end
    end
  end

  describe '#turn' do
    context 'when robot is placed' do
      before { robot.place(position, ToyRobotSimulator::Direction::NORTH) }

      it 'rotates the robot left' do
        robot.turn(:left)
        expect(robot.direction).to eq(ToyRobotSimulator::Direction::WEST)
      end

      it 'does not change position' do
        original_position = robot.position
        robot.turn(:left)
        expect(robot.position).to eq(original_position)
      end
    end

    context 'when robot is not placed' do
      it 'does nothing' do
        robot.turn(:left)
        expect(robot.placed?).to be false
      end
    end
  end

  describe 'turning right' do
    context 'when robot is placed' do
      before { robot.place(position, ToyRobotSimulator::Direction::NORTH) }

      it 'rotates the robot right' do
        robot.turn(:right)
        expect(robot.direction).to eq(ToyRobotSimulator::Direction::EAST)
      end

      it 'does not change position' do
        original_position = robot.position
        robot.turn(:right)
        expect(robot.position).to eq(original_position)
      end
    end

    context 'when robot is not placed' do
      it 'does nothing' do
        robot.turn(:right)
        expect(robot.placed?).to be false
      end
    end
  end

  describe '#report' do
    context 'when robot is placed' do
      it 'returns formatted position and direction' do
        robot.place(ToyRobotSimulator::Position.new(1, 2), ToyRobotSimulator::Direction::EAST)
        expect(robot.report).to eq('1,2,EAST')
      end
    end

    context 'when robot is not placed' do
      it 'returns nil' do
        expect(robot.report).to be_nil
      end
    end
  end
end
