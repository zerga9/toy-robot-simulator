# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobotSimulator::Readers::FileReader do
  let(:fixture_path) { File.expand_path('../../fixtures', __dir__) }

  describe '#read' do
    context 'with valid file' do
      let(:valid_file) { File.join(fixture_path, 'valid_commands.txt') }

      it 'yields each line from the file' do
        reader = described_class.new(valid_file)
        lines = []
        reader.read { |line| lines << line.chomp }

        expect(lines).to eq(['PLACE 0,0,NORTH', 'MOVE', 'REPORT'])
      end
    end

    context 'with empty file' do
      let(:empty_file) { File.join(fixture_path, 'empty_file.txt') }

      it 'does not yield any lines' do
        reader = described_class.new(empty_file)
        lines = []
        reader.read { |line| lines << line }

        expect(lines).to be_empty
      end
    end

    context 'with nonexistent file' do
      it 'outputs error and does not raise' do
        reader = described_class.new('/nonexistent/file.txt')
        allow(File).to receive(:foreach).with('/nonexistent/file.txt').and_raise(Errno::ENOENT)

        expect { reader.read { |_line| } }.to output(/not found/).to_stderr
        expect { reader.read { |_line| } }.not_to raise_error
      end
    end

    context 'with permission denied' do
      it 'outputs error and does not raise' do
        reader = described_class.new('/restricted/file.txt')
        allow(File).to receive(:foreach).with('/restricted/file.txt').and_raise(Errno::EACCES)

        expect { reader.read { |_line| } }.to output(/Permission denied/).to_stderr
        expect { reader.read { |_line| } }.not_to raise_error
      end
    end
  end

  describe '#filename' do
    it 'returns the filename' do
      reader = described_class.new('/path/to/file.txt')
      expect(reader.filename).to eq('/path/to/file.txt')
    end
  end
end
