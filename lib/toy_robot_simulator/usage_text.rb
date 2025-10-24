# frozen_string_literal: true

module ToyRobotSimulator
  USAGE_TEXT = <<~USAGE
        ___
       |[X]|     TOY ROBOT SIMULATOR
       /   \\     ===================
      |  O  |
      |_____|
      |  |  |
      |__|__|

    Commands:
      PLACE X,Y,DIRECTION - Place robot at position (X,Y) facing NORTH/SOUTH/EAST/WEST
      MOVE                - Move robot one unit forward
      LEFT                - Turn robot 90 degrees counter-clockwise
      RIGHT               - Turn robot 90 degrees clockwise
      REPORT              - Output robot's current position

    Note: The first command must be PLACE. All other commands are ignored until
          the robot is placed on the table.

    Enter commands (one per line). Type exit or quit to exit.

  USAGE
end
