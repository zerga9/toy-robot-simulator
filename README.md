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
