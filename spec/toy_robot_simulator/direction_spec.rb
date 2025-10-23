require 'spec_helper'

RSpec.describe ToyRobotSimulator::Direction do
  describe '#initialize' do
    it 'initializes with name and delta values' do
      direction = described_class.new('NORTH', 1, 2)

      expect(direction.name).to eq('NORTH')
      expect(direction.dir_x).to eq(1)
      expect(direction.dir_y).to eq(2)
    end
  end

  describe 'direction constants' do
    let(:directions) do
      [
        { constant: described_class::NORTH, name: 'NORTH', dir_x: 0, dir_y: 1 },
        { constant: described_class::EAST, name: 'EAST', dir_x: 1, dir_y: 0 },
        { constant: described_class::SOUTH, name: 'SOUTH', dir_x: 0, dir_y: -1 },
        { constant: described_class::WEST, name: 'WEST', dir_x: -1, dir_y: 0 }
      ]
    end

    it 'has correct names for all constants' do
      directions.each do |dir|
        expect(dir[:constant].name).to eq(dir[:name])
      end
    end

    it 'has correct delta values for all constants' do
      directions.each do |dir|
        expect(dir[:constant].dir_x).to eq(dir[:dir_x])
        expect(dir[:constant].dir_y).to eq(dir[:dir_y])
      end
    end
  end

  describe '#turn_left' do
    it 'rotates counter-clockwise through all directions' do
      expect(described_class::NORTH.turn_left).to eq(described_class::WEST)
      expect(described_class::WEST.turn_left).to eq(described_class::SOUTH)
      expect(described_class::SOUTH.turn_left).to eq(described_class::EAST)
      expect(described_class::EAST.turn_left).to eq(described_class::NORTH)
    end
  end

  describe '#turn_right' do
    it 'rotates clockwise through all directions' do
      expect(described_class::NORTH.turn_right).to eq(described_class::EAST)
      expect(described_class::EAST.turn_right).to eq(described_class::SOUTH)
      expect(described_class::SOUTH.turn_right).to eq(described_class::WEST)
      expect(described_class::WEST.turn_right).to eq(described_class::NORTH)
    end
  end
end
