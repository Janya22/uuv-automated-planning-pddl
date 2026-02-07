# uuv-automated-planning-pddl

# UUV Automated Planning using PDDL

This project models an automated underwater inspection mission for offshore wind farms
using **PDDL (Planning Domain Definition Language)**. The system plans missions for
Unmanned Underwater Vehicles (UUVs) operating in a constrained, fully autonomous
environment.


---

## Problem Overview

A ship deploys one or more UUVs to perform underwater inspection tasks in the North Sea.
The UUVs can:
- Navigate between underwater waypoints
- Capture images
- Perform sonar scans
- Collect physical samples and return them to a ship

The planning problem is subject to constraints such as:
- Limited onboard memory (one data item at a time)
- Single deployment per UUV
- Samples must be physically returned to a ship
- Ships can store only one sample

---

## Project Structure

### Part A – Domain Modelling
- Defined object types: UUVs, ships, waypoints
- Implemented predicates describing world state
- Implemented actions such as:
  - deploy-uuv
  - move
  - take-pic
  - sonar-scan
  - transmit-img
  - transmit-sonar
  - collect-sample
  - return-sample

### Part B – Mission Problems
- **Problem 1**: Image + sonar data collection
- **Problem 2**: Image, sonar, and sample collection
- **Problem 3**: Multi-UUV and multi-ship coordination

### Part C – Domain Extension
- Introduced a human engineer onboard the ship
- Added ship locations: bay and control centre
- Deployment and communication constrained by engineer position


---
## Plan Output:

<img width="1218" height="1043" alt="image" src="https://github.com/user-attachments/assets/fc714f6b-083f-45d7-838b-5dff4ec25cfb" />

