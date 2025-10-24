# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::Simulator do
  subject(:simulator) { described_class.new }

  let(:place_command) { { command: :place, x: 0, y: 0, direction: ToyRobotSimulator::Direction::NORTH } }

  describe '#initialize' do
    it { expect(simulator.robot).to be_a(ToyRobotSimulator::Robot) }
    it { expect(simulator.table).to be_a(ToyRobotSimulator::Table) }
    it { expect(simulator.robot).not_to be_placed }
  end

  describe '#execute' do
    context 'with PLACE command' do
      it 'places the robot' do
        simulator.execute(place_command)
        expect(simulator.robot).to be_placed
        expect(simulator.robot.position.x).to eq(0)
        expect(simulator.robot.position.y).to eq(0)
        expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::NORTH)
      end

      it 'allows replacing robot' do
        simulator.execute(place_command)
        simulator.execute({ command: :place, x: 3, y: 3, direction: ToyRobotSimulator::Direction::SOUTH })

        expect(simulator.robot.position.x).to eq(3)
        expect(simulator.robot.position.y).to eq(3)
        expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::SOUTH)
      end
    end

    context 'with movement commands' do
      before { simulator.execute(place_command) }

      it 'executes MOVE' do
        expect { simulator.execute({ command: :move }) }
          .to change { simulator.robot.position.y }.from(0).to(1)
      end

      it 'executes LEFT' do
        expect { simulator.execute({ command: :left }) }
          .to change { simulator.robot.direction }
          .from(ToyRobotSimulator::Direction::NORTH).to(ToyRobotSimulator::Direction::WEST)
      end

      it 'executes RIGHT' do
        expect { simulator.execute({ command: :right }) }
          .to change { simulator.robot.direction }
          .from(ToyRobotSimulator::Direction::NORTH).to(ToyRobotSimulator::Direction::EAST)
      end

      it 'executes REPORT' do
        expect { simulator.execute({ command: :report }) }
          .to output("0,0,NORTH\n").to_stdout
      end

      it 'executes multiple commands in sequence' do
        simulator.execute({ command: :move })
        simulator.execute({ command: :right })

        expect(simulator.robot.position).to have_attributes(x: 0, y: 1)
        expect(simulator.robot.direction).to eq(ToyRobotSimulator::Direction::EAST)
      end
    end

    context 'with nil or unknown command' do
      it 'does nothing for nil' do
        expect { simulator.execute(nil) }.not_to raise_error
        expect(simulator.robot).not_to be_placed
      end

      it 'does nothing for unknown command' do
        expect { simulator.execute({ command: :unknown }) }.not_to raise_error
      end
    end

    context 'before placement' do
      %i[move left right report].each do |cmd|
        it "ignores #{cmd.upcase}" do
          expect { simulator.execute(command: cmd) }
            .not_to(change { simulator.robot.placed? })
        end
      end
    end
  end
end
