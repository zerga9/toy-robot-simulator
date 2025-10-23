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
