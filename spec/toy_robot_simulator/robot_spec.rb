# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::Robot do
  subject(:robot) { described_class.new }

  let(:position) { ToyRobotSimulator::Position.new(0, 0) }
  let(:direction) { ToyRobotSimulator::Direction::NORTH }

  describe '#initialize' do
    it { is_expected.not_to be_placed }

    it 'has no position' do
      expect(robot.position).to be_nil
    end

    it 'has no direction' do
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
    context 'when not placed' do
      it { is_expected.not_to be_placed }
    end

    context 'when placed' do
      before { robot.place(position, direction) }

      it { is_expected.to be_placed }
    end
  end

  describe '#move' do
    context 'when placed' do
      {
        NORTH: { from: [2, 2], to: [2, 3] },
        EAST: { from: [2, 2], to: [3, 2] },
        SOUTH: { from: [2, 2], to: [2, 1] },
        WEST: { from: [2, 2], to: [1, 2] }
      }.each do |dir, positions|
        it "moves #{dir.downcase} correctly" do
          robot.place(ToyRobotSimulator::Position.new(*positions[:from]),
                      ToyRobotSimulator::Direction.const_get(dir))
          robot.move
          expect(robot.position.x).to eq(positions[:to][0])
          expect(robot.position.y).to eq(positions[:to][1])
        end
      end
    end

    context 'when not placed' do
      it 'does nothing' do
        expect { robot.move }.not_to change(robot, :position)
      end
    end
  end

  describe '#turn' do
    shared_examples 'ignores turn when not placed' do |rotation|
      context 'when not placed' do
        it 'does nothing' do
          robot.turn(rotation)
          expect(robot).not_to be_placed
        end
      end
    end

    shared_examples 'rotates when placed' do |rotation, expected_direction_name|
      context 'when placed' do
        let(:expected_direction) { ToyRobotSimulator::Direction.const_get(expected_direction_name) }

        before { robot.place(position, ToyRobotSimulator::Direction::NORTH) }

        it "rotates #{rotation}" do
          robot.turn(rotation)
          expect(robot.direction).to eq(expected_direction)
        end

        it 'does not change position' do
          expect { robot.turn(rotation) }.not_to change(robot, :position)
        end
      end
    end

    context 'turning left' do
      include_examples 'rotates when placed', :left, :WEST
      include_examples 'ignores turn when not placed', :left
    end

    context 'turning right' do
      include_examples 'rotates when placed', :right, :EAST
      include_examples 'ignores turn when not placed', :right
    end
  end

  describe '#report' do
    context 'when placed' do
      it 'returns formatted position and direction' do
        robot.place(ToyRobotSimulator::Position.new(1, 2), ToyRobotSimulator::Direction::EAST)
        expect(robot.report).to eq('1,2,EAST')
      end
    end

    context 'when not placed' do
      it { expect(robot.report).to be_nil }
    end
  end
end
