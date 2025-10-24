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

# If you get a permission denied error, make it executable first
chmod +x bin/setup

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
0,0,SOUTH          # Ignored the move, would fall off!
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
    cli.rb              # Command line interface
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

## My Approach

When I started this, I wanted to keep things simple while showing good design practices. I focused on making each class do one thing well. The `Robot` knows how to move and turn, the `Table` checks if positions are valid, the `Direction` handles all the rotation logic, and the `CommandParser` translates text into actions. This way, when I write tests or need to change something, I know exactly where to look.

The `Direction` class was interesting to work on. Instead of scattering direction logic throughout the code with lots of if statements, I made it a proper object. Each direction knows its name and which way it moves on the grid. When the robot needs to turn left or right, it's just simple math on an array of directions. It felt really satisfying to solve rotation this way because the code is clean and there are no conditionals to maintain.

I thought carefully about how the robot should handle mistakes. The instructions for the challenge made it clear that the application should discard the commands until there is a valid one, so the robot just quietly ignores any command that would make it fall off the table. It also won't do anything until you place it first with a valid PLACE command. This makes the simulator safe and predictable.

For reading commands, I built separate reader classes for stdin and files. They both work the same way from the outside, which keeps the CLI simple. If someone wanted to add more input sources later, like reading from a network socket or building a web interface, they could just create another reader class without touching any of the core logic.

I wrote tests as I went, starting with the requirements and then adding edge cases as I thought of them. The test suite ended up with 91 examples that cover everything from basic movement to boundary checking to invalid input. I kept refactoring as I wrote more tests. My goal was that anyone looking at this code could understand what's happening and know where to make changes. If you wanted a bigger table or new commands, the structure makes it obvious where those changes would go.

I decided not to package this as a Ruby gem because it's a self-contained application rather than a library that other projects would depend on. Gems make sense when you're building reusable code that needs to be distributed and versioned. This is a command line simulator, running directly, so keeping it simple as a Ruby project felt like the right choice.

## What I'd Add With More Time

If I had another day or two, I'd add code coverage reporting with SimpleCov to see exactly which lines are tested. It helps catch edge cases you might have missed.

I'd also make the table size configurable instead of hardcoding 5×5. Right now it works for the requirements, but making it flexible would be a nice. Something like `Table.new(width: 10, height: 10)` would do it, and all the existing validation logic would just work.

A visual representation of the table would be nice to add. When you run REPORT, it could draw a simple ASCII grid showing where the robot is and which direction it's facing. It would make the simulator more satisfying to play with and easier to debug complex sequences of moves.

I'd probably add a command history feature too. Being able to type something like UNDO or HISTORY would let you experiment more freely. You could try a sequence of moves, undo if you don't like it, and try a different path. It would make the interactive mode more powerful without changing the core robot logic at all.

It would be interesting to support multiple robots on the same table. You could name them and give commands like PLACE ROBOT1 0,0,NORTH and MOVE ROBOT2. The tricky part would be collision detection, making sure robots don't occupy the same space. That would add a whole new dimension to the simulation and make it more of a puzzle to solve.
