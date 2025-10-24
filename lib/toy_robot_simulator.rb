# frozen_string_literal: true

require_relative 'toy_robot_simulator/cli'
require_relative 'toy_robot_simulator/command_parser'
require_relative 'toy_robot_simulator/direction'
require_relative 'toy_robot_simulator/position'
require_relative 'toy_robot_simulator/readers/stdin_reader'
require_relative 'toy_robot_simulator/readers/file_reader'
require_relative 'toy_robot_simulator/robot'
require_relative 'toy_robot_simulator/simulator'
require_relative 'toy_robot_simulator/table'

module ToyRobotSimulator
  VERSION = '0.1.0'
end
