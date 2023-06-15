.. lmx2594_test_app application

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

.. _lmx2594_test_app:

``lmx2594_test_app.xml`` Application
====================================

Test application for the ``lmx2594_proxy.rcc`` RCC Worker and ``lmx2594.hdl`` HDL Device Worker.

.. _application_diagram:

.. figure:: lmx2594_test_app.svg
   :alt: alt text
   :align: center

   Block Diagram of Application XML

Detail
------

The user is encouraged to explore the ``lmx2594_proxy-worker.rst`` and ``lmx2594-worker.rst`` documents to understand how the LMX2594 device was developed.

Pre-Proxy
---------

The LMX2594 contains a ``pre_proxy_script`` directory which contains a ``program.sh`` script. This "pre-proxy" programming script serves as a way to test the HDL Device Worker before creating an RCC proxy. This script is used to perform basic ``set`` and ``get`` functionality to check the integrity of the VHDL state machine for the HDL Device Worker, and the functionality of the device.

TICS Pro provided files
-----------------------

The provided tics_pro.txt in this directory was generated based on a 100 MHz input clock oscillator. Using 100 MHz as the input clock oscillator, several register values files have been generated (100 MHz, 75 MHz, 50 MHz, and 25 MHz) and provided in the ``clk_osc_test_files/``. To test the validity of these register values files, the user can execute the scripts and probe register R180 to test the integrity of the clock oscillator.

Prerequisites
-------------

The ``zrf8_48dr`` has been properly installed and deployed, and the application assembly bitstream is built. Specifically, this test application requires the following assets are built:

   * HDL Assembly: ``empty`` with container ``cnt_zrf8_48dr_lmx2594.xml`` (From the ``zrf8_48dr`` OSP)
   * RCC Proxy: ``lmx2594_proxy.rcc``.

Properties
----------

The ``lmx2594_test_app.xml`` defines the following ``values`` for the ``lmx2594_proxy.rcc`` properties:

   ``tics_pro.txt`` value for ``lmx2594_proxy`` property ``in_filename``.

      - **File Description:** The ``tics_pro.txt`` file represents the register set file that is exported from the Texas Instruments Tics-Pro Windows based utility. The ``tics_pro.txt`` file is provided in this application directory as a default.

      - **The default** ``tics_pro.txt`` **file was configured for a 100 MHz input clock oscillator. If the user wishes to change this file for a custom Tics-Pro register set configuration file, refer to the** ``lmx2594_proxy-worker.rst``.

   ``outfile.txt`` value for ``lmx2594_proxy`` property ``outfile.txt``.

      - **File Description:**: The ``outfile.txt`` file represents the output file that is generated once the application has been successfully executed. Upon success, the ``outfile.txt`` is configured to match the ``tics_pro.txt`` input file.

Execution
---------

.. note::

   The instructions are written for **Standalone Mode**

..

#. Boot the ``zrf8_48dr``, setup Standalone Mode, then browse to the following directory:

   ``cd /home/root/opencpi/applications/lmx2594_test_app``

#. Run the application

   ``ocpirun -v -d -x -t 1 lmx2594_test_app.xml``

#. Compare the ``md5sum`` check-sum of the ``tics_pro.txt`` file and the ``outfile.txt`` file.

#. **Successful completion of this application is a matching MD5 check-sum. This indicates that the application has written a register set defined in the** ``tics_pro.txt`` **file and that identical register set has been read from the device and output to the** ``outfile.txt``.

Example of stdout, for the default tics_pro.txt file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block::

   % ocpirun -v -d -x -t 1 lmx2594_test_app.xml
   Available containers are:  0: PL:0 [model: hdl os:  platform: zrf8_48dr], 1: rcc0 [model: rcc os: linux platform: xilinx21_1_aarch64]
   Actual deployment is:
     Instance  0 lmx2594_proxy (spec ocpi.osp.hitech_global.devices.lmx2594_proxy) on rcc container 1: rcc0, using lmx2594_proxy in /media/sd-mmcblk0p1/opencpi/xilinx21_1_aarch64/artifacts/lmx2594_proxy.so dated Thu Mar 15 10:51:46 2018
     Instance  1 lmx2594_proxy.lmx2594 (spec ocpi.osp.hitech_global.devices.lmx2594) on hdl container 0: PL:0, using lmx2594/c/lmx2594 in /media/sd-mmcblk0p1/opencpi/artifacts/empty_zrf8_48dr_base_cnt_zrf8_48dr_lmx2594.bitz dated Thu Mar 15 10:50:14 2018
   Application XML parsed and deployments (containers and artifacts) chosen [0 s 43 ms]
   Application established: containers, workers, connections all created [2 s 2 ms]
   Dump of all initial property values:
   Property   3: lmx2594_proxy.in_filename = "tics_pro.txt" (cached)
   Property   4: lmx2594_proxy.out_filename = "outfile.txt" (cached)
   Property   8: lmx2594_proxy.lmx2594.CP_CLK_FREQ_HZ_p = "0x5f5e100" (parameter)
   Property   9: lmx2594_proxy.lmx2594.SPI_CLK_FREQ_HZ_p = "0xf4240" (parameter)
   Property  10: lmx2594_proxy.lmx2594.register_0 = "0x2410"
   Property  11: lmx2594_proxy.lmx2594.register_1 = "0x80b"
   Property  12: lmx2594_proxy.lmx2594.register_2 = "0x500"
   Property  13: lmx2594_proxy.lmx2594.register_3 = "0x642"
   Property  14: lmx2594_proxy.lmx2594.register_4 = "0xa43"
   Property  15: lmx2594_proxy.lmx2594.register_5 = "0xc8"
   Property  16: lmx2594_proxy.lmx2594.register_6 = "0xc802"
   Property  17: lmx2594_proxy.lmx2594.register_7 = "0xb2"
   Property  18: lmx2594_proxy.lmx2594.register_8 = "0x2000"
   Property  19: lmx2594_proxy.lmx2594.register_9 = "0x604"
   Property  20: lmx2594_proxy.lmx2594.register_10 = "0x10d8"
   Property  21: lmx2594_proxy.lmx2594.register_11 = "0x18"
   Property  22: lmx2594_proxy.lmx2594.register_12 = "0x5001"
   Property  23: lmx2594_proxy.lmx2594.register_13 = "0x4000"
   Property  24: lmx2594_proxy.lmx2594.register_14 = "0x1e70"
   Property  25: lmx2594_proxy.lmx2594.register_15 = "0x64f"
   Property  26: lmx2594_proxy.lmx2594.register_16 = "0x80"
   Property  27: lmx2594_proxy.lmx2594.register_17 = "0xfa"
   Property  28: lmx2594_proxy.lmx2594.register_18 = "0x64"
   Property  29: lmx2594_proxy.lmx2594.register_19 = "0x27b7"
   Property  30: lmx2594_proxy.lmx2594.register_20 = "0xb848"
   Property  31: lmx2594_proxy.lmx2594.register_21 = "0x401"
   Property  32: lmx2594_proxy.lmx2594.register_22 = "0x1"
   Property  33: lmx2594_proxy.lmx2594.register_23 = "0x7c"
   Property  34: lmx2594_proxy.lmx2594.register_24 = "0x71a"
   Property  35: lmx2594_proxy.lmx2594.register_25 = "0x624"
   Property  36: lmx2594_proxy.lmx2594.register_26 = "0xdb0"
   Property  37: lmx2594_proxy.lmx2594.register_27 = "0x2"
   Property  38: lmx2594_proxy.lmx2594.register_28 = "0x488"
   Property  39: lmx2594_proxy.lmx2594.register_29 = "0x2108"
   Property  40: lmx2594_proxy.lmx2594.register_30 = "0x2108"
   Property  41: lmx2594_proxy.lmx2594.register_31 = "0x43e8"
   Property  42: lmx2594_proxy.lmx2594.register_32 = "0x393"
   Property  43: lmx2594_proxy.lmx2594.register_33 = "0x1e21"
   Property  44: lmx2594_proxy.lmx2594.register_34 = "0x0"
   Property  45: lmx2594_proxy.lmx2594.register_35 = "0x4"
   Property  46: lmx2594_proxy.lmx2594.register_36 = "0x32"
   Property  47: lmx2594_proxy.lmx2594.register_37 = "0x204"
   Property  48: lmx2594_proxy.lmx2594.register_38 = "0xffff"
   Property  49: lmx2594_proxy.lmx2594.register_39 = "0xffff"
   Property  50: lmx2594_proxy.lmx2594.register_40 = "0x0"
   Property  51: lmx2594_proxy.lmx2594.register_41 = "0x0"
   Property  52: lmx2594_proxy.lmx2594.register_42 = "0x0"
   Property  53: lmx2594_proxy.lmx2594.register_43 = "0x0"
   Property  54: lmx2594_proxy.lmx2594.register_44 = "0x1fa2"
   Property  55: lmx2594_proxy.lmx2594.register_45 = "0xcedf"
   Property  56: lmx2594_proxy.lmx2594.register_46 = "0x7fd"
   Property  57: lmx2594_proxy.lmx2594.register_47 = "0x300"
   Property  58: lmx2594_proxy.lmx2594.register_48 = "0x300"
   Property  59: lmx2594_proxy.lmx2594.register_49 = "0x4180"
   Property  60: lmx2594_proxy.lmx2594.register_50 = "0x0"
   Property  61: lmx2594_proxy.lmx2594.register_51 = "0x80"
   Property  62: lmx2594_proxy.lmx2594.register_52 = "0x820"
   Property  63: lmx2594_proxy.lmx2594.register_53 = "0x0"
   Property  64: lmx2594_proxy.lmx2594.register_54 = "0x0"
   Property  65: lmx2594_proxy.lmx2594.register_55 = "0x0"
   Property  66: lmx2594_proxy.lmx2594.register_56 = "0x0"
   Property  67: lmx2594_proxy.lmx2594.register_57 = "0x0"
   Property  68: lmx2594_proxy.lmx2594.register_58 = "0x8001"
   Property  69: lmx2594_proxy.lmx2594.register_59 = "0x1"
   Property  70: lmx2594_proxy.lmx2594.register_60 = "0x3e8"
   Property  71: lmx2594_proxy.lmx2594.register_61 = "0xa8"
   Property  72: lmx2594_proxy.lmx2594.register_62 = "0xaf"
   Property  73: lmx2594_proxy.lmx2594.register_63 = "0x0"
   Property  74: lmx2594_proxy.lmx2594.register_64 = "0x1388"
   Property  75: lmx2594_proxy.lmx2594.register_65 = "0x0"
   Property  76: lmx2594_proxy.lmx2594.register_66 = "0x1f4"
   Property  77: lmx2594_proxy.lmx2594.register_67 = "0x0"
   Property  78: lmx2594_proxy.lmx2594.register_68 = "0x3e8"
   Property  79: lmx2594_proxy.lmx2594.register_69 = "0x0"
   Property  80: lmx2594_proxy.lmx2594.register_70 = "0xc350"
   Property  81: lmx2594_proxy.lmx2594.register_71 = "0x80"
   Property  82: lmx2594_proxy.lmx2594.register_72 = "0x1"
   Property  83: lmx2594_proxy.lmx2594.register_73 = "0x3f"
   Property  84: lmx2594_proxy.lmx2594.register_74 = "0x0"
   Property  85: lmx2594_proxy.lmx2594.register_75 = "0x800"
   Property  86: lmx2594_proxy.lmx2594.register_76 = "0xc"
   Property  87: lmx2594_proxy.lmx2594.register_77 = "0x0"
   Property  88: lmx2594_proxy.lmx2594.register_78 = "0x64"
   Property  89: lmx2594_proxy.lmx2594.register_79 = "0x0"
   Property  90: lmx2594_proxy.lmx2594.register_80 = "0x0"
   Property  91: lmx2594_proxy.lmx2594.register_81 = "0x0"
   Property  92: lmx2594_proxy.lmx2594.register_82 = "0x0"
   Property  93: lmx2594_proxy.lmx2594.register_83 = "0x0"
   Property  94: lmx2594_proxy.lmx2594.register_84 = "0x0"
   Property  95: lmx2594_proxy.lmx2594.register_85 = "0x0"
   Property  96: lmx2594_proxy.lmx2594.register_86 = "0x0"
   Property  97: lmx2594_proxy.lmx2594.register_87 = "0x0"
   Property  98: lmx2594_proxy.lmx2594.register_88 = "0x0"
   Property  99: lmx2594_proxy.lmx2594.register_89 = "0x0"
   Property 100: lmx2594_proxy.lmx2594.register_90 = "0x0"
   Property 101: lmx2594_proxy.lmx2594.register_91 = "0x0"
   Property 102: lmx2594_proxy.lmx2594.register_92 = "0x0"
   Property 103: lmx2594_proxy.lmx2594.register_93 = "0x0"
   Property 104: lmx2594_proxy.lmx2594.register_94 = "0x0"
   Property 105: lmx2594_proxy.lmx2594.register_95 = "0x0"
   Property 106: lmx2594_proxy.lmx2594.register_96 = "0x0"
   Property 107: lmx2594_proxy.lmx2594.register_97 = "0x0"
   Property 108: lmx2594_proxy.lmx2594.register_98 = "0x0"
   Property 109: lmx2594_proxy.lmx2594.register_99 = "0x0"
   Property 110: lmx2594_proxy.lmx2594.register_100 = "0x0"
   Property 111: lmx2594_proxy.lmx2594.register_101 = "0x0"
   Property 112: lmx2594_proxy.lmx2594.register_102 = "0x0"
   Property 113: lmx2594_proxy.lmx2594.register_103 = "0x0"
   Property 114: lmx2594_proxy.lmx2594.register_104 = "0x0"
   Property 115: lmx2594_proxy.lmx2594.register_105 = "0x4440"
   Property 116: lmx2594_proxy.lmx2594.register_106 = "0x7"
   Property 117: lmx2594_proxy.lmx2594.register_107 = "0x8801"
   Property 118: lmx2594_proxy.lmx2594.register_108 = "0xf2"
   Property 119: lmx2594_proxy.lmx2594.register_109 = "0x9800"
   Property 120: lmx2594_proxy.lmx2594.register_110 = "0x708"
   Property 121: lmx2594_proxy.lmx2594.register_111 = "0xb7"
   Property 122: lmx2594_proxy.lmx2594.register_112 = "0xfa"
   Application started/running [1 s 5 ms]
    [1 s 5 ms]
   Dump of all final property values:
   Property   3: lmx2594_proxy.in_filename = "tics_pro.txt" (cached)
   Property   4: lmx2594_proxy.out_filename = "outfile.txt" (cached)
   Property  10: lmx2594_proxy.lmx2594.register_0 = "0x2510"
   Property  11: lmx2594_proxy.lmx2594.register_1 = "0x808"
   Property  12: lmx2594_proxy.lmx2594.register_2 = "0x500"
   Property  13: lmx2594_proxy.lmx2594.register_3 = "0x642"
   Property  14: lmx2594_proxy.lmx2594.register_4 = "0xa43"
   Property  15: lmx2594_proxy.lmx2594.register_5 = "0xc8"
   Property  16: lmx2594_proxy.lmx2594.register_6 = "0xc802"
   Property  17: lmx2594_proxy.lmx2594.register_7 = "0x40b2"
   Property  18: lmx2594_proxy.lmx2594.register_8 = "0x2000"
   Property  19: lmx2594_proxy.lmx2594.register_9 = "0x1604"
   Property  20: lmx2594_proxy.lmx2594.register_10 = "0x10d8"
   Property  21: lmx2594_proxy.lmx2594.register_11 = "0x18"
   Property  22: lmx2594_proxy.lmx2594.register_12 = "0x5001"
   Property  23: lmx2594_proxy.lmx2594.register_13 = "0x4000"
   Property  24: lmx2594_proxy.lmx2594.register_14 = "0x1e70"
   Property  25: lmx2594_proxy.lmx2594.register_15 = "0x64f"
   Property  26: lmx2594_proxy.lmx2594.register_16 = "0x80"
   Property  27: lmx2594_proxy.lmx2594.register_17 = "0x12c"
   Property  28: lmx2594_proxy.lmx2594.register_18 = "0x64"
   Property  29: lmx2594_proxy.lmx2594.register_19 = "0x27b7"
   Property  30: lmx2594_proxy.lmx2594.register_20 = "0xe048"
   Property  31: lmx2594_proxy.lmx2594.register_21 = "0x401"
   Property  32: lmx2594_proxy.lmx2594.register_22 = "0x1"
   Property  33: lmx2594_proxy.lmx2594.register_23 = "0x7c"
   Property  34: lmx2594_proxy.lmx2594.register_24 = "0x71a"
   Property  35: lmx2594_proxy.lmx2594.register_25 = "0xc2b"
   Property  36: lmx2594_proxy.lmx2594.register_26 = "0xdb0"
   Property  37: lmx2594_proxy.lmx2594.register_27 = "0x2"
   Property  38: lmx2594_proxy.lmx2594.register_28 = "0x488"
   Property  39: lmx2594_proxy.lmx2594.register_29 = "0x318c"
   Property  40: lmx2594_proxy.lmx2594.register_30 = "0x318c"
   Property  41: lmx2594_proxy.lmx2594.register_31 = "0x43ec"
   Property  42: lmx2594_proxy.lmx2594.register_32 = "0x393"
   Property  43: lmx2594_proxy.lmx2594.register_33 = "0x1e21"
   Property  44: lmx2594_proxy.lmx2594.register_34 = "0x0"
   Property  45: lmx2594_proxy.lmx2594.register_35 = "0x4"
   Property  46: lmx2594_proxy.lmx2594.register_36 = "0x46"
   Property  47: lmx2594_proxy.lmx2594.register_37 = "0x404"
   Property  48: lmx2594_proxy.lmx2594.register_38 = "0x0"
   Property  49: lmx2594_proxy.lmx2594.register_39 = "0x3e8"
   Property  50: lmx2594_proxy.lmx2594.register_40 = "0x0"
   Property  51: lmx2594_proxy.lmx2594.register_41 = "0x0"
   Property  52: lmx2594_proxy.lmx2594.register_42 = "0x0"
   Property  53: lmx2594_proxy.lmx2594.register_43 = "0x0"
   Property  54: lmx2594_proxy.lmx2594.register_44 = "0x1fa3"
   Property  55: lmx2594_proxy.lmx2594.register_45 = "0xc0df"
   Property  56: lmx2594_proxy.lmx2594.register_46 = "0x7fc"
   Property  57: lmx2594_proxy.lmx2594.register_47 = "0x300"
   Property  58: lmx2594_proxy.lmx2594.register_48 = "0x300"
   Property  59: lmx2594_proxy.lmx2594.register_49 = "0x4180"
   Property  60: lmx2594_proxy.lmx2594.register_50 = "0x0"
   Property  61: lmx2594_proxy.lmx2594.register_51 = "0x80"
   Property  62: lmx2594_proxy.lmx2594.register_52 = "0x820"
   Property  63: lmx2594_proxy.lmx2594.register_53 = "0x0"
   Property  64: lmx2594_proxy.lmx2594.register_54 = "0x0"
   Property  65: lmx2594_proxy.lmx2594.register_55 = "0x0"
   Property  66: lmx2594_proxy.lmx2594.register_56 = "0x0"
   Property  67: lmx2594_proxy.lmx2594.register_57 = "0x20"
   Property  68: lmx2594_proxy.lmx2594.register_58 = "0x9001"
   Property  69: lmx2594_proxy.lmx2594.register_59 = "0x1"
   Property  70: lmx2594_proxy.lmx2594.register_60 = "0x0"
   Property  71: lmx2594_proxy.lmx2594.register_61 = "0xa8"
   Property  72: lmx2594_proxy.lmx2594.register_62 = "0x322"
   Property  73: lmx2594_proxy.lmx2594.register_63 = "0x0"
   Property  74: lmx2594_proxy.lmx2594.register_64 = "0x1388"
   Property  75: lmx2594_proxy.lmx2594.register_65 = "0x0"
   Property  76: lmx2594_proxy.lmx2594.register_66 = "0x1f4"
   Property  77: lmx2594_proxy.lmx2594.register_67 = "0x0"
   Property  78: lmx2594_proxy.lmx2594.register_68 = "0x3e8"
   Property  79: lmx2594_proxy.lmx2594.register_69 = "0x0"
   Property  80: lmx2594_proxy.lmx2594.register_70 = "0xc350"
   Property  81: lmx2594_proxy.lmx2594.register_71 = "0x81"
   Property  82: lmx2594_proxy.lmx2594.register_72 = "0x1"
   Property  83: lmx2594_proxy.lmx2594.register_73 = "0x3f"
   Property  84: lmx2594_proxy.lmx2594.register_74 = "0x0"
   Property  85: lmx2594_proxy.lmx2594.register_75 = "0x800"
   Property  86: lmx2594_proxy.lmx2594.register_76 = "0xc"
   Property  87: lmx2594_proxy.lmx2594.register_77 = "0x0"
   Property  88: lmx2594_proxy.lmx2594.register_78 = "0x3"
   Property  89: lmx2594_proxy.lmx2594.register_79 = "0x0"
   Property  90: lmx2594_proxy.lmx2594.register_80 = "0x0"
   Property  91: lmx2594_proxy.lmx2594.register_81 = "0x0"
   Property  92: lmx2594_proxy.lmx2594.register_82 = "0x0"
   Property  93: lmx2594_proxy.lmx2594.register_83 = "0x0"
   Property  94: lmx2594_proxy.lmx2594.register_84 = "0x0"
   Property  95: lmx2594_proxy.lmx2594.register_85 = "0x0"
   Property  96: lmx2594_proxy.lmx2594.register_86 = "0x0"
   Property  97: lmx2594_proxy.lmx2594.register_87 = "0x0"
   Property  98: lmx2594_proxy.lmx2594.register_88 = "0x0"
   Property  99: lmx2594_proxy.lmx2594.register_89 = "0x0"
   Property 100: lmx2594_proxy.lmx2594.register_90 = "0x0"
   Property 101: lmx2594_proxy.lmx2594.register_91 = "0x0"
   Property 102: lmx2594_proxy.lmx2594.register_92 = "0x0"
   Property 103: lmx2594_proxy.lmx2594.register_93 = "0x0"
   Property 104: lmx2594_proxy.lmx2594.register_94 = "0x0"
   Property 105: lmx2594_proxy.lmx2594.register_95 = "0x0"
   Property 106: lmx2594_proxy.lmx2594.register_96 = "0x0"
   Property 107: lmx2594_proxy.lmx2594.register_97 = "0x888"
   Property 108: lmx2594_proxy.lmx2594.register_98 = "0x0"
   Property 109: lmx2594_proxy.lmx2594.register_99 = "0x0"
   Property 110: lmx2594_proxy.lmx2594.register_100 = "0x0"
   Property 111: lmx2594_proxy.lmx2594.register_101 = "0x11"
   Property 112: lmx2594_proxy.lmx2594.register_102 = "0x0"
   Property 113: lmx2594_proxy.lmx2594.register_103 = "0x0"
   Property 114: lmx2594_proxy.lmx2594.register_104 = "0x0"
   Property 115: lmx2594_proxy.lmx2594.register_105 = "0x21"
   Property 116: lmx2594_proxy.lmx2594.register_106 = "0x0"
   Property 117: lmx2594_proxy.lmx2594.register_107 = "0x8801"
   Property 118: lmx2594_proxy.lmx2594.register_108 = "0xf2"
   Property 119: lmx2594_proxy.lmx2594.register_109 = "0x9800"
   Property 120: lmx2594_proxy.lmx2594.register_110 = "0x708"
   Property 121: lmx2594_proxy.lmx2594.register_111 = "0xb7"
   Property 122: lmx2594_proxy.lmx2594.register_112 = "0x12c"

..
