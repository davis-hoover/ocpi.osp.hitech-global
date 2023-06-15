.. lmx2594_proxy.rcc RCC worker

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

.. _lmx2594_proxy.rcc-RCC-worker:

``lmx2594_proxy.rcc`` RCC Worker
================================

.. warning:: **CRITICAL WARNING:**

   This HDL Worker will be relocated to opencpi/projects/platform/hdl/devices to best support component reuse.

RCC Device Worker for the Texas Instruments LMX2594 15-GHz Wideband PLLATINUM(TM) RF Synthesizer

Detail
------

Implementation of the lmx2594 RCC device worker for the Texas Instruments lmx2594 High Performance, Wideband PLLatinum(TM) RF Synthesizer with Integrated VCO.

Data-Sheet: https://www.ti.com/lit/ds/symlink/lmx2594.pdf

The worker is used in either file configuration mode or property configuration mode. If the ``in_filename`` property value is an empty string, the property configuration mode is used, meaning no input file is read and the register_ properties must be written to in the manner described in step 4 in the datasheet section 7.5.1 (https://www.ti.com/lit/ds/symlink/lmx2594.pdf) before the worker start operation.
If the ``in_filename`` property value is non-empty, the file configuration mode is used, meaning the ``in_filename`` property must contain the path to a TICSPRO output file whose rows are applied, one register per row, in the order they appears in the file. Note that OpenCPI does not have a standardized concept of a shared filesystem.

Note that in either configuration mode this worker autonomously performs steps 2-3 and 5-6 of the datasheet section 7.5.1 for the user. Steps 2-3 are performed internally before the first register write that occurs at the beginning of step 4, and steps 5-6 are performed internally during the worker start operation.

Texas Instruments TICS PRO Software Utility
-------------------------------------------

The Texas Instruments TICS PRO Software **Windows-based** provides the user with a GUI to configure the LMX2594 to meet their requirements and exports a \*.txt registers file based which can be used as a basis for programming the hardware device.

This proxy was developed to utilize the custom \*.txt registers file to program the LMX2594.

   - TICS PRO Software link: https://www.ti.com/tool/TICSPRO-SW

This proxy can be tested by utilizing the application ``zrf8_48dr_lmx2594_test_app``. This application is located here: ``ocpi.osp.hitech-global/applications/zrf8_48dr_lmx2594_test_app/``. The application directory contains a ``tics_pro.txt`` file that can be used as a "default" LMX2594 configuration.

   - TICS PRO Software default file location:

     ``ocpi.osp.hitech-global/applications/zrf8_48dr_lmx2594_test_app/tics_pro.txt``

   **CRITICAL WARNING:**

      - The provided "tics_pro.txt" file was generated based on an input clock oscillator frequency equal to 100 MHz.

      - If you would like to use a different configuration, then construct a new ``\.*txt`` register file and replace the old ``tics_pro.txt`` file with the new one.

	- BUT KEEP THE FILE NAME THE SAME, otherwise the example OpenCPI Application Specification XML (OAS.xml) for the test app must be modify per the new file name.**

Properties
----------

Property name ``in_filename``:

- This property is of type ``string`` and can be used to define the name of a file that was generated using TICSPRO Software and contains a register set.

Property name ``out_filename``:

 - This property is of type ``string`` and can be used to define the name of an output file that is written in the working directory during application execution.

TICS PRO Software Register \*.txt file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following steps are only necessary if file configuration mode is used.

#. Install the Tics-Pro Windows-based utility

   TICS PRO Software software link: https://www.ti.com/tool/TICSPRO-SW

#. Open the software tool and construct a custom configuration for desired implementation.

#. Generate a \*.txt file

   File -> Export hex register values

#. Copy the \*.txt file any directories from which any application using this worker will be run (example shown below)

   ``scp *.txt <device>:/home/root/opencpi/applications/zrf8_48dr_lmx2594_test_app/tics_pro.txt``

Build the RCC-Worker
^^^^^^^^^^^^^^^^^^^^

See ocpidev documentation. An example build command is as follows:

   ``ocpidev build --rcc-platform xilinx21_1_aarch64``

Testing
^^^^^^^

The ``zrf8_48dr_lmx2594_test_app`` application defines the value of the ``in_filename`` and ``out_filename`` properties, as ``tics_pro.txt`` and ``outfile.txt``, respectively. This proxy worker parses the ``tics_pro.txt`` to perform ``slave.set_register*`` commands to set the properties, i.e., register values, defined in the ``lmx2594.hdl/lmx2594.xml``. Then performs ``get_register(*)`` commands to retrieve the contents of each register from the LMX2594 device. The ``outfile.txt`` is then set at the application level, which results in a write of a file with in the same format as the input ``tics_pro.txt`` file. After the application has been executed, the user can compare, e.g. by performing an ``md5sum`` checksum, on each of the \*.txt files to check the integrity of setting up (i.e. write/read) the LMX2594 device.

#. Setup target platform for Standalone Mode and copy all \*.so and \*.bitz and tics_pro.txt files relevant to the application onto its SD card.

#. ``cd /home/root/opencpi/applications``

#. ``ocpirun -v -d -t 1 zrf8_48dr_lmx2594_test_app``

#. ``mdsum tics_pro.txt outfile.txt``
