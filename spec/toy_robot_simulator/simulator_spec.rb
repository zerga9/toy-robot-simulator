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

  describe '#robot' do
    it 'returns the robot instance' do
      expect(simulator.robot).to be_a(ToyRobotSimulator::Robot)
    end
  end

  describe '#table' do
    it 'returns the table instance' do
      expect(simulator.table).to be_a(ToyRobotSimulator::Table)
    end
  end

  describe '#execute' do
    let(:place_command) do
      { command: :place, x: 0, y: 0, direction: ToyRobotSimulator::Direction::NORTH }
    end

    it 'executes place command' do
      simulator.execute(place_command)
      expect(simulator.robot.placed?).to be true
      expect(simulator.robot.position.x).to eq(0)
      expect(simulator.robot.position.y).to eq(0)
      expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::NORTH)
    end

    it 'ignores nil command' do
      expect { simulator.execute(nil) }.not_to raise_error
      expect(simulator.robot.placed?).to be false
    end

    it 'executes multiple commands in sequence' do
      simulator.execute(place_command)
      simulator.execute({ command: :move })
      simulator.execute({ command: :right })

      expect(simulator.robot.position.x).to eq(0)
      expect(simulator.robot.position.y).to eq(1)
      expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::EAST)
    end

    it 'executes move command' do
      simulator.execute(place_command)
      simulator.execute({ command: :move })

      expect(simulator.robot.position.y).to eq(1)
    end

    it 'executes left turn command' do
      simulator.execute(place_command)
      simulator.execute({ command: :left })

      expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::WEST)
    end

    it 'executes right turn command' do
      simulator.execute(place_command)
      simulator.execute({ command: :right })

      expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::EAST)
    end

    it 'executes report command without error' do
      simulator.execute(place_command)
      expect { simulator.execute({ command: :report }) }.to output("0,0,NORTH\n").to_stdout
    end

    it 'allows replacing robot at different valid position' do
      simulator.execute({ command: :place, x: 0, y: 0, direction: ToyRobotSimulator::Direction::NORTH })
      simulator.execute({ command: :place, x: 3, y: 3, direction: ToyRobotSimulator::Direction::SOUTH })

      expect(simulator.robot.position.x).to eq(3)
      expect(simulator.robot.position.y).to eq(3)
      expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::SOUTH)
    end

    context 'with nil command' do
      it 'does nothing' do
        simulator.execute(nil)
        expect(simulator.robot).not_to be_placed
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

    context 'before placement' do
      %i[move left right report].each do |cmd|
        it "ignores #{cmd.to_s.upcase} before placement" do
          expect { simulator.execute(command: cmd) }
            .not_to(change { [simulator.robot.position, simulator.robot.direction, simulator.robot.placed?] })
        end
      end
    end
  end
end
