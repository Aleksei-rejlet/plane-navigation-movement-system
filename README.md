# plane-navigation-movement-system

## Overview

This repository implements a small Ada-based Stall Prevention System (SPS) simulation for a plane navigation and movement control scenario. It models:

- `AoA` (Angle of Attack) sensor unit with three sensors and majority voting
- `PCU` (Pilot Console Unit) for stall prevent mode toggle and alarm control
- `HSU` (Horizontal Stabilizer Unit) that sets tailplane position
- `SPU` (Stall Prevention Unit) controller logic combining sensor data and pilot mode
- `Env` package to drive input from an environment data file
- `Log` package to record system state and decisions into a log file

The main program `Test_SPS` reads environment data from `env.dat`, updates the system, runs the SPS controller, and writes runtime output into `log.dat`.

## Project structure

- `src/` - Ada source files for all system components
- `codinghere.gpr` - GNAT project file for building the repository
- `env.dat` - input data file used by the environment simulation
- `log.dat` - generated output log file after running the program
- `obj/` - compiled object files and temporary build output

## What it does

At each simulation step, the program:

1. Reads three AoA sensor values from `env.dat`
2. Computes a majority sensor reading and detects undefined values
3. Reads the pilot's Stall Prevent Mode button signal
4. Updates PCU status and alarm state
5. Applies SPU control rules to set the tailplane position in HSU
6. Records the current input and state in `log.dat`

The controller logic includes stall prevention checks and alarm enable/disable behavior based on sensor thresholds.

## Requirements

To build and run this repository, you need:

- GNAT Ada compiler (GNAT 2020 or later recommended)
- GNAT Studio or GNAT command-line tools
- A Unix-like shell environment (Linux recommended)

If you want to use GNAT Studio, open `codinghere.gpr` as the project file.

## Build and run

### Using GNAT Studio

1. Open GNAT Studio.
2. Open the project file `codinghere.gpr`.
3. Build the project.
4. Run the main program `test_sps`.
5. Make sure `env.dat` is present in the project root before running.

### Using the command line

From the repository root:

```sh
gprbuild -P codinghere.gpr
./obj/test_sps
```

If you prefer `gnatmake`, you can also use:

```sh
gnatmake -P codinghere.gpr
./test_sps
```

## Input and output

- Input: `env.dat` in the repository root
- Output: `log.dat` created in the repository root

## Notes

- The source code uses Ada/SPARK style packages with explicit state tracking.
- `codinghere.gpr` configures the compiler to use `-gnat2020`.
- `env.dat` must contain valid integer values for three sensors and a Stall Prevent Mode button state at each step.
