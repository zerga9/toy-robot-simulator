# Toy Robot Simulator

## User Stories

### Story 1: Place Robot on Table

**As a** user
**I want to** place a robot on the table at a specific position and direction
**So that** I can start simulating robot movements

**Acceptance Criteria:**

- Given the table is 5x5 units
- When I issue command `PLACE 0,0,NORTH`
- Then the robot is placed at position (0,0) facing NORTH
- And the robot is ready to accept further commands

**Examples:**

```
PLACE 0,0,NORTH   → Robot at (0,0) facing NORTH
PLACE 2,3,EAST    → Robot at (2,3) facing EAST
PLACE 4,4,SOUTH   → Robot at (4,4) facing SOUTH
```

---

### Story 2: Prevent Invalid Initial Placement

**As a** user
**I want** invalid PLACE commands to be ignored
**So that** the robot doesn't fall off the table during initial placement

**Acceptance Criteria:**

- Given the table is 5x5 (positions 0-4 are valid)
- When I issue command `PLACE 5,5,NORTH`
- Then the command is ignored
- And the robot remains unplaced
- And further commands are ignored until a valid PLACE command

**Examples:**

```
PLACE 10,10,NORTH → Ignored (out of bounds)
PLACE -1,0,NORTH  → Ignored (negative position)
PLACE 0,5,NORTH   → Ignored (y=5 is off table)
```

---

### Story 3: Ignore Commands Before Placement

**As a** user
**I want** all commands before the first valid PLACE to be ignored
**So that** I don't execute commands on an unplaced robot

**Acceptance Criteria:**

- Given the robot has not been placed
- When I issue other commands than PLACE
- Then all commands are ignored
- When I issue a valid PLACE command
- Then the robot is placed
- And subsequent commands are executed

**Example:**

```
MOVE              → Ignored
LEFT              → Ignored
REPORT            → Ignored
PLACE 0,0,NORTH   → Robot placed
MOVE              → Executed
```

---

### Story 4: Move Robot Forward

**As a** user
**I want to** move the robot one unit forward in its current direction
**So that** I can navigate the robot around the table

**Acceptance Criteria:**

- Given the robot is placed at a valid position
- When I issue command `MOVE`
- Then the robot moves 1 unit forward in its current facing direction
- NORTH increases Y by 1
- EAST increases X by 1
- SOUTH decreases Y by 1
- WEST decreases X by 1

**Examples:**

```
Position (0,0) facing NORTH + MOVE → Position (0,1)
Position (2,2) facing EAST + MOVE  → Position (3,2)
Position (3,3) facing SOUTH + MOVE → Position (3,2)
Position (2,2) facing WEST + MOVE  → Position (1,2)
```

---

### Story 5: Prevent Robot From Falling Off Table

**As a** user
**I want** the robot to ignore MOVE commands that would make it fall
**So that** the robot stays on the table and doesn't get destroyed

**Acceptance Criteria:**

- Given the robot is at the edge of the table
- When I issue a MOVE command that would take it off the table
- Then the MOVE command is ignored
- And the robot remains at its current position
- And the robot can still accept further valid commands

**Examples:**

```
At (0,0) facing SOUTH + MOVE → Stays at (0,0)
At (0,0) facing WEST + MOVE  → Stays at (0,0)
At (4,4) facing NORTH + MOVE → Stays at (4,4)
At (4,4) facing EAST + MOVE  → Stays at (4,4)
```

---

### Story 6: Rotate Robot Left

**As a** user
**I want to** rotate the robot 90 degrees counter-clockwise
**So that** I can change the robot's facing direction

**Acceptance Criteria:**

- Given the robot is placed on the table
- When I issue command `LEFT`
- Then the robot rotates 90 degrees counter-clockwise
- And the robot's position does not change
- NORTH → WEST
- WEST → SOUTH
- SOUTH → EAST
- EAST → NORTH

**Examples:**

```
Facing NORTH + LEFT → Facing WEST
Facing WEST + LEFT  → Facing SOUTH
Facing SOUTH + LEFT → Facing EAST
Facing EAST + LEFT  → Facing NORTH
```

---
