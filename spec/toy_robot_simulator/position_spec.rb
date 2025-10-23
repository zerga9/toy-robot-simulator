require 'spec_helper'

RSpec.describe ToyRobotSimulator::Position do
  subject(:position) { described_class.new(2, 3) }
  describe '#initialize' do
    it 'sets the x coordinate' do
      expect(subject.x).to eq(2)
    end

    it 'sets the y coordinate' do
      expect(subject.y).to eq(3)
    end
  end
end
