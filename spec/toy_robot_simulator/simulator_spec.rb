require 'spec_helper'

RSpec.describe ToyRobotSimulator::Simulator do
  subject(:simulator) { described_class.new }

  describe '#initialize' do
    it 'creates simulator with robot and table' do
      expect(simulator.robot).to be_a(ToyRobotSimulator::Robot)
      expect(simulator.table).to be_a(ToyRobotSimulator::Table)
    end

    it 'robot is not placed initially' do
      expect(simulator.robot.placed?).to be false
    end
  end

  describe '#execute' do
    context 'with PLACE command' do
      it 'places robot at valid position (0,0) facing NORTH' do
        command = { command: :place, x: 0, y: 0, direction: :north }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be true
        expect(simulator.robot.position.x).to eq(0)
        expect(simulator.robot.position.y).to eq(0)
        expect(simulator.robot.direction).to eq(:north)
      end

      it 'places robot at valid position (2,3) facing EAST' do
        command = { command: :place, x: 2, y: 3, direction: :east }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be true
        expect(simulator.robot.position.x).to eq(2)
        expect(simulator.robot.position.y).to eq(3)
        expect(simulator.robot.direction).to eq(:east)
      end

      it 'places robot at valid position (4,4) facing SOUTH' do
        command = { command: :place, x: 4, y: 4, direction: :south }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be true
        expect(simulator.robot.position.x).to eq(4)
        expect(simulator.robot.position.y).to eq(4)
        expect(simulator.robot.direction).to eq(:south)
      end

      it 'places robot facing WEST' do
        command = { command: :place, x: 1, y: 1, direction: :west }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be true
        expect(simulator.robot.direction).to eq(:west)
      end

      it 'does not place robot at invalid position (negative x)' do
        command = { command: :place, x: -1, y: 0, direction: :north }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be false
      end

      it 'does not place robot at invalid position (negative y)' do
        command = { command: :place, x: 0, y: -1, direction: :north }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be false
      end

      it 'does not place robot at invalid position (x >= 5)' do
        command = { command: :place, x: 5, y: 0, direction: :north }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be false
      end

      it 'does not place robot at invalid position (y >= 5)' do
        command = { command: :place, x: 0, y: 5, direction: :north }
        simulator.execute(command)

        expect(simulator.robot.placed?).to be false
      end

      it 'allows replacing robot at different valid position' do
        simulator.execute({ command: :place, x: 0, y: 0, direction: :north })
        simulator.execute({ command: :place, x: 3, y: 3, direction: :south })

        expect(simulator.robot.position.x).to eq(3)
        expect(simulator.robot.position.y).to eq(3)
        expect(simulator.robot.direction).to eq(:south)
      end
    end

    context 'with nil command' do
      it 'does nothing' do
        simulator.execute(nil)
        expect(simulator.robot.placed?).to be false
      end

      it 'does not raise error' do
        expect { simulator.execute(nil) }.not_to raise_error
      end
    end

    context 'with unknown command' do
      it 'does nothing for unrecognized command' do
        command = { command: :unknown }
        expect { simulator.execute(command) }.not_to raise_error
      end
    end
  end
end
