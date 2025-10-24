# Toy Robot Simulator

```
    ___
   |[X]|
   /   \
  |  O  |
  |_____|
  |  |  |
  |__|__|
```

A simple robot simulator that moves around a 5×5 table. The robot won't fall off (it's been trained well).

**Requirements:** Ruby 3.0 or higher

## Quick Start

```bash
# Setup
./bin/setup

# Run interactively
ruby ./bin/toy_robot

# Or from a file
ruby ./bin/toy_robot examples/example1.txt

# Run tests
bundle exec rspec
```

## How it works

You control a robot on a 5×5 grid (positions 0-4 on both X and Y axes). The robot ignores any command that would make it fall off.

### Commands

```
PLACE X,Y,DIRECTION  Place robot at position (X,Y) facing NORTH/SOUTH/EAST/WEST
MOVE                 Move one unit forward
LEFT                 Turn 90° counter-clockwise
RIGHT                Turn 90° clockwise
REPORT               Show current position (outputs: X,Y,DIRECTION)
EXIT or QUIT         Exit the simulator
```

**Important:** The first valid command must be `PLACE`. Everything before that is ignored.

## Examples

### Interactive mode
```
> PLACE 0,0,NORTH
> MOVE
> REPORT
0,1,NORTH
> RIGHT
> MOVE
> REPORT
1,1,EAST
```

### Edge protection
```
> PLACE 0,0,SOUTH
> MOVE
> REPORT
0,0,SOUTH          # Ignored the move - would fall off!
```

### Commands from file
Create a file `commands.txt`:
```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```

Run it:
```bash
./bin/toy_robot commands.txt
# Output: 3,3,NORTH
```

## Project Structure

```
lib/
  toy_robot_simulator/
    cli.rb              # Command-line interface
    command_parser.rb   # Parses text commands
    direction.rb        # Cardinal directions with rotation
    position.rb         # X,Y coordinates
    robot.rb            # The robot itself
    simulator.rb        # Main simulator logic
    table.rb            # 5×5 table with bounds checking
    readers/            # Input sources (stdin, file)
```

## Development

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/toy_robot_simulator/robot_spec.rb

# Check code style
bundle exec rubocop
```

Built with Ruby and RSpec
