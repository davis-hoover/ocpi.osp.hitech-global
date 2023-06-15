This MUST be built with the following ocpidev arguments: --hdl-target zynq_ultra

This MUST be built
1) with no newer than Xilinx 2021.1, as Xilinx 2021.2 is known to have a more recent version (2.6) of the RF Data Converter IP which has not been tested against, and which the build scripts herein do not support without modification (current version is 2.5), and
2) with the OpenCPI Xilinx specified which supports the xczu48dr part (some machines/installations did require this and some didn't).
An example of the commands which meet these two requirements is shown below.

    export OCPI_XILINX_VIVADO_VERSION=2021.1
    export OCPI_XILINX_LICENSE_FILE=2100@myserver

TODO - investigate why ocpidev's --hdl-platform argument does not work on this

See [rfdc.hdl documentation](../../devices/rfdc.hdl/rfdc-worker.rst) for more info
about this primitive and its design philosophy.
