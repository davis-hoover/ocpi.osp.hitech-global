# Pre-proxy Register Initialization script

The program.sh script was a "first-pass" at setting up the lmx2594 device. This was done outside of a proxy to take advantage of the ocpihdl set and get utility that is available once OpenCPI has been sourced on the device.

If the user intends to create another set of register values that they wish to set/get, or want to create a similar "pre-proxy" script for another device-worker, the first three commands that are present in the program.sh script **MUST** be followed:

**Unreset and Start Worker**

These two commands take the device-worker out of the "reset" state and place the device worker into the "start" state. These states are outlined in the OpenCPI\_HDL\_Development\_Guide under the "Life Cycle/Control Operation Signals in the Control Interface" section.

The "3" represents the "index" of the device worker as implemented in the bitstream, as is critical for the script to function properly. The index can be determine by first loading the bistream (``ocpihdl load <name>.bit``), then readback (``ocpihdl get``) of the PL ROM which the compressed *-art.xml of the design.

  - ocpihdl wunreset 3

  - ocpihdl wop 3 start

**Set the control register timeout**

This command sets the "control register timeout" of the device-worker. If you have implemented a non-default timeout value for the device worker in the device-worker.xml "controlinterface Timeout=value" that value will also need to be set here.

For example, the lmx2594 device-worker 

  - ocpihdl wwctl 3 0x80000012

# Procedure:

1. Boot the Device

2. Setup OpenCPI on the device (Standalone mode was tested during this scenario)

3. Set the appropriate OCPI\_LIBRARY\_PATH=

4. Run the program.sh script

  ./program.sh
