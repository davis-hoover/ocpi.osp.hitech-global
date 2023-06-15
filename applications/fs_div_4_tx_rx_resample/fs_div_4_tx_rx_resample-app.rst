.. fs_div_4_tx_rx_resample application

.. This file is protected by Copyright. Please refer to the COPYRIGHT file
   distributed with this source distribution.

   This file is part of OpenCPI <http://www.opencpi.org>

   OpenCPI is free software: you can redistribute it and/or modify it under the
   terms of the GNU Lesser General Public License as published by the Free
   Software Foundation, either version 3 of the License, or (at your option) any
   later version.

   OpenCPI is distributed in the hope that it will be useful, but WITHOUT ANY
   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
   A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
   more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.

..

:orphan:

.. _fs_div_4_tx_rx_resample:

``fs_div_4_tx_rx_resample.xml`` Application
===========================================
Verifies Digital Radio Controller (DRC)-based control, and HDL worker sources and sinks for I/Q data at a highly decimated/interpolated data rate of 90 ksps, for all RF ports on the HiTech Global ZRF8-48DR using a spectrum analyzer to verify TX and an I/Q snapshot to file for RX. Only TX J13 and RX J20 are verified, but application is expected to actually transmits/receive on all available HiTech Global ports.

.. figure:: fs_div_4_tx_rx_resample.svg
   :alt: alt text
   :align: center

   Block Diagram of Application XML

Detail
------

This application serves as an example for using the HiTech Global RF Data
Converter and its DRC interface with the ocpi.comp.sdr resampling workers that
allow for a sampling rate different than the builtime-fixed rate of 90 Msps for
the RF Data Converter. The cic_decimator_xs_htg.hdl and cic_interpolator_xs.hdl
workers decimate and interpolate, respectively, by a factor of 1000, resulting
in a baseband sampling rate of 90 ksps.
The HiTech Global's J20 RX RF port is dumped to a file named j20_rx.bin during
runtime. A recommend test setup is to connect J20 to a signal generator with a
390.975 MHz tone at -30 dBm and observing the baseband signal with a complex
sinusoid at 25 kHz and sampled at 90 ksps using the plot_bin.m octave script.

Tested Platforms
----------------
# zrf8_48dr built with Xilinx Vivado 2021.1 and xilinx21_1_aarch64

Prerequisites
-------------

#. HiTech Global's J13 TX RF port is connected to a spectrum analyzer
#. A system is available which has octave installed for plotting the j20_rx.bin output file
#. The ``zrf8_48dr`` has been properly installed and deployed, and the following assets are built and their artifacts (.bitz file for HDL and .so for RCC) exist within a directory that exists FIRST within colon-separate OCPI_LIBRARY_PATH environment variable value:

   * HDL Assembly: ``fs_div_4_tx_rx_resample`` built for ``zrf8_48dr``
   * RCC: drc.rcc (ocpi.osp.hitech_global project) built for xilinx21_1_aarch64 platform
   * RCC: lmx2594_proxy.rcc built for xilinx21_1_aarch64 platform
   * RCC: file_write.rcc (ocpi.core project) built for xilinx21_1_aarch64 platform

#. The fs_div_4_tx_rx_resample.xml file is in the working directory

Execution
---------

#. Boot the ``zrf8_48dr`` and setup for the desired mode (Standalone, Network, Server)

#. Run the application

   ``ocpirun -t 1 fs_div_4_tx_rx_resample.xml``

#. Copy the j20_rx.bin file to the system which can run octave
#. Verification:

  #. RX: Drive the HTG input J20 with a signal generator with a 390.975 MHz tone at -30 dBm. Run the plot_bin.m octave script from the directory containing j20_rx.bin to plot the received data and verify that the baseband signal with a complex sinusoid at +25.0 kHz and sampled at 90 ksps (use Ctrl-D to exit octave once done)::

   ``octave --persist plot_bin.m``

Known Issues
------------
* The cic_decimator_xs_htg.hdl workers numerically overflows without producing an
  error. This is mitigated by limiting the composite amplitude/gain of the
  1) signal sent to the RX RF ports by the signal generator
  2) cic_decimator_xs.hdl scale_output_value

Troubleshooting
---------------

If a runtime log occurs that indicates "lock FAILED", the drc configurations
property was likely not set according to the contrained ranges described in
its worker documentation. An example log output of a user requesting a tuning freq of
1000 MHz, which the underlying radio was not capable of,
produces the following error::

    [INFO] lock SUCCEEDED for rf_port_name: J13 for config: direction for value: 1
    [INFO] lock FAILED for rf_port_name: J13 for config: tuning_freq_MHz for value: 1000 w/ tolerance: +/- 0.01
    [INFO] for rf_port_name J13: unlocking config direction
    [INFO] rf_port_name J13 did not meet requirements
    Exiting for exception: Code 0x17, level 0, error: 'Worker "drc" produced an error during the "start" control operation: config prepare request was unsuccessful, set OCPI_LOG_LEVEL to 8 (or higher) for more info'
