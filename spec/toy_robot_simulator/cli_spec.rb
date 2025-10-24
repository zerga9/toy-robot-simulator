# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::CLI do
  let(:fixture_path) { File.expand_path('../fixtures', __dir__) }

  def stub_stdin(input)
    allow($stdin).to receive(:tty?).and_return(false)
    allow($stdin).to receive(:each_line) do |&block|
      input.split("\n").each { |line| block.call(line) }
    end
  end

  describe '#run' do
    before { allow_any_instance_of(described_class).to receive(:print_usage) }

    context 'when reading from a file' do
      let(:valid_commands_file) { File.join(fixture_path, 'valid_commands.txt') }
      let(:cli) { described_class.new([valid_commands_file]) }

      it 'executes commands and outputs results' do
        expect { cli.run }.to output(/0,1,NORTH/).to_stdout
      end
    end

    context 'when reading from stdin' do
      let(:cli) { described_class.new([]) }

      it 'executes commands and outputs results' do
        stub_stdin("PLACE 1,2,EAST\nREPORT")
        expect { cli.run }.to output(/1,2,EAST/).to_stdout
      end

      it 'handles multiple commands in sequence' do
        stub_stdin("PLACE 0,0,NORTH\nMOVE\nRIGHT\nREPORT")
        expect { cli.run }.to output(/0,1,EAST/).to_stdout
      end

      it 'ignores commands before a valid PLACE' do
        stub_stdin("MOVE\nLEFT\nPLACE 0,0,NORTH\nREPORT")
        expect { cli.run }.to output(/0,0,NORTH/).to_stdout
      end
    end

    context 'when file does not exist' do
      let(:cli) { described_class.new(['/nonexistent/file.txt']) }

      it 'outputs an error message to stderr' do
        expect { cli.run }.to output(/not found/).to_stderr
      end

      it 'does not raise an error' do
        expect { cli.run }.not_to raise_error
      end
    end

    context 'when stdin is empty' do
      let(:cli) { described_class.new([]) }

      it 'completes without error' do
        stub_stdin('')
        expect { cli.run }.not_to raise_error
      end
    end
  end

  describe '#create_reader' do
    context 'with no arguments' do
      it 'creates a StdinReader' do
        cli = described_class.new([])
        expect(cli.send(:create_reader)).to be_a(ToyRobotSimulator::Readers::StdinReader)
      end
    end

    context 'with a file argument' do
      it 'creates a FileReader' do
        cli = described_class.new(['example.txt'])
        expect(cli.send(:create_reader)).to be_a(ToyRobotSimulator::Readers::FileReader)
      end
    end
  end
end
