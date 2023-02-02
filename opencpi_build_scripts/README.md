The top.sh script will complete all of the following:

  1. Build HDL Primitives libraries of "main" projects

  2. Build HDL Worker libraries of "main" projects

  3. Build Component Unit Tests for core, assets, and assets\_ts

  4. Run Component Unit Tests for core, assets, and assets\_ts

  5. Verify Component Unit Tests for core, assets, and assets\_ts

Implementation:

  1. Boot the Device

  2. Setup Server Mode

  3. Source opencpi

  4. export OCPI\_XILINX\_VIVADO\_VERSION=2021.1

  5. ./top.sh
