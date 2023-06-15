.. Guide for developing Device / Proxy Workers

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


:orphan:

.. _Guide for developing Device/ Proxy Workers:

Guide for developing Device / Proxy Workers
===========================================

Introduction
------------

This document provides an OpenCPI developer the instructions for developing ``Device Workers``, ``Pre-Proxy testing``, ``Device Proxies``, ``Applications``, and ``ACI's``  for hardware devices that exist on a hardware platform which are external to an FPGA.

Used as a ``Case Study`` throughout this guide, the SPI bus for the ADS7038 of the Hitech-Gloabl ZRF8 (herein "zrf8_48dr") is referenced to help the developer understand each of the steps.

The implementation is available in the ``ocpi.osp.hitech-global`` ZRF8 OSP.

Upon completion of this guide, an OpenCPI developer should be equipped with the knowledge to implement support for their own HDL and RCC device workers.

Documentation
^^^^^^^^^^^^^

This document includes **some** limited definitions and framework direction but the developer is encouraged to reference the OpenCPI guides for further information. Below is a list of guides that are explicitly referenced.

   #. `OpenCPI Platform Development Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_Platform_Development_Guide.pdf>`_

   #. `OpenCPI User Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_User_Guide.pdf>`_

   #. All zrf8 ``Device Workers``, ``Device Proxies``, test ``Applications``, and test ``ACI's`` contain an associated \*.rst datasheet that provides additional information.

Applicable ADS7038 documentation:

   This documentation should first be referenced as a introduction to the ADS7038 device.

   - HDL Device Documentation: ``hdl/devices/ads7038.hdl/ads7038-worker.rst``

   - RCC Proxy Documentation: ``hdl/devices/ads7038_proxy.rcc/ads7038_proxy-worker.rst``

   - ADS7038 Test Application: ``applications/zrf8_48dr_ads7038_test_app/zrf8_48dr_ads7038_test_app-app.rst``

   - ADS7038 Test Application ACI: ``applications/zrf8_48dr_ads7038_test_app/zrf8_48dr_ads7038_test_app-app.rst``

Limitations
^^^^^^^^^^^

This section details all ``Limitations`` (documented FOSS ``Issues``) with the OpenCPI framework that have been shown to impact the development of device workers and proxies in support of this implementation.

   #. BUG: No support for Xilinx 2021.1 (mainly Petalinux 2021.1) including issue with deploying and executing on embedded system.

      * https://gitlab.com/opencpi/opencpi/-/issues/3420

   #. BUG: ocpihdl does not correctly apply HDL worker control plane timeout

      * https://gitlab.com/opencpi/opencpi/-/issues/3558

Research
--------

During this stage of development, the developer must gather information about the external devices' register map and connectivity. If the device is COTS, then the register map should be available in a published datasheet. The connectivity of the device is normally only available via schematics or sometimes with various guides that are provided by the manufacturer of the platform.

In this case study the connectivity is available from the manufacturer's documentation.

If the device address, pin number, component datasheet, or register map are not easily obtainable, then the developer may have to inquire about this information by other means such as email, or manufacturer forum posts.

Platform Manufacturer Research
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At minimum, the following information must be identified:

   #. Manufacturer and part number for each of the device(s) present on the platform.

   #. FPGA Pin number(s) in support of the device or additional signals required for enabling access to the devices.

Component Manufacturer Research
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At minimum, the following information must be identified:

   #. Device datasheet

   #. Device register map and accessibility (Read/Write, Read only, Write only)

   #. Default register values

**Device Datasheets**:

   #. `ADS7038 Datasheet <https://www.ti.com/lit/ds/symlink/ads7038.pdf?ts=1678903101407&ref_url=https%253A%252F%252Fwww.google.com%252F>`_

**Device Register Map**:

The device register map for the device can be found within its respective device datasheet. The register map for the device can also be reviewed in the ``hdl/devices/ads7038.hdl/ads7038.xml`` file.

**Default register values**:

The default register values for this device can be found within the device datasheet.

Build Flow
----------

#. ``Device Worker`` - The developer leverages the information gathered in the ``Research`` phase to develop the ``Device Worker``. This development includes but is not limited to, SPI state machine development, device-register set and accessability, and FPGA pin connectivity.

#. ``Pre-Proxy`` (optional) - The ``Pre-Proxy`` script can be created to test the basic functionality of the ``Device Worker``. Basic functionality includes testing the SPI state machine (VHDL), and testing basic set and get functionality of the register set. This step can be done before implementing the ``Device-Proxy`` to test the ``Device Worker`` implementation independent of a ``Device Proxy``.

# ``Sub-device Worker`` - The ``Sub-device worker`` implements the required sharing of low level hardware between device workers such as shared SPI communication. It is defined to support some number of device workers, and is thus instantiated whenever any of its supported device workers are instantiated in a platform configuraiton or container.

#. ``Device-Proxy`` -  The ``Device Proxy`` establishes a basic programmatic functionality for the device register-set and any particular functionality of the device that the user has established during the research phase of development. This implemented functionality typically creates an "easier-to-use" interface for the device register set.

#. Device ``Application`` - Develop a device ``application`` which utilizes some or all of the ``Device Proxy`` properties to initialize or configure the deivce in a particular implementation that is outside of the default configuration (as defined by the device data-sheet).

#. Device Application Control Interface ``ACI`` (optional) - The OpenCPI Application Control Interface (ACI) gives the user the ability to create programmatic and/or dynamic creation or control of the XML-based application.

Check-list
----------

Below is a Check-list that that can be leveraged by the user to develop the HDL Device Worker, Pre-Proxy script, RCC Proxy, Application, and ACI.

Device Worker
^^^^^^^^^^^^^

[ ] - Review the ADS7038 datasheet to capture properties/types.

[ ] - Review the ADS7038 datasheet for the SPI interface timing diagrams, this should be referenced for designing the VHDL SPI Primitive.

[ ] - Create Device Worker

   [ ] - Create the ads7038 Device Worker XML ``ads7038.xml``

   [ ] - Create the ads7038 Device Worker SPI primitive VHDL ``spi_ads7038.vhd``

   [ ] - Create the ads7038 Device Worker VHDL ``ads7038.vhd`` which utilizes the ``spi_ads7038.vhd`` SPI primitive

   [ ] - Create the ads7038 Device Worker build XML ``ads7038-build.xml`` (optional)

   [ ] - Create the ads7038 Device Worker ``signals.vhd`` file

   [ ] - Create the ads7038 Device Worker VHDL PKG ``ads7038_pkg.vhd``

   [ ] - (Optional) Create the ads7038 Device Worker Proxy test ``ads7038_proxy_test.vhd``

   [ ] - (Optional) Create the ads7038 Device Worker SPI Primitive Test Bench VHDL ``tb_spi_ads7038.vhd``

   [ ] - Makefile: Update as needed.

[ ] - Create an empty assembly for testing the Device Worker.

[ ] - Create documentation for the Device Worker.

Pre-Proxy
^^^^^^^^^

[ ] - Create a ``Pre-Proxy`` programming script

   - [ ] Test ``get`` functionality of the ``HDL Device Worker``

   - [ ] Test ``set`` functionality of the ``HDL Device Worker``

Sub-device Worker
^^^^^^^^^^^^^^^^^

#TODO

Device Proxy
^^^^^^^^^^^^

[ ] - Create Device Proxy

   [ ] - Create the ads7038 Device Proxy XML ``ads7038_proxy-rcc.xml``

   [ ] - Create the ads7038 Device Proxy C++ ``ads7038_proxy.cc``

[ ] - Makefile: Update as needed.

[ ] - Create documentation for the Device Proxy.

Application
^^^^^^^^^^^

[ ] - Create Application

[ ] - Makefile: Update as needed.

[ ] - Create documentation for the application.

ACI
^^^

[ ] - Create an OpenCPI Application Control Interface (ACI).

   [ ] - Determine any dynamic/programmatic functionality that the device needs to perform that is not possible with a device application. Such as:

      - The contents of the application XML (OAS) need to be constructed programmatically or some of its attributes need to be dynamically set.

      - The C++ main program needs to directly connect to the ports of the running application, and send or receive data to/from it.

      - The XML-based application needs to be run repeatedly (perhaps with configuration changes) in the same process.

      - Component property values need to be read or written dynamically during the execution of the application.

HDL Platform Worker
^^^^^^^^^^^^^^^^^^^

[ ] - Declare Device/Subdevice Workers in the Platform Worker OWD

HDL Assembly
^^^^^^^^^^^^

[ ] - Create the ads7038 Empty Assembly ``empty.xml``

[ ] - Create the ads7038 Container ``cnt_zrf8_48dr_ads7038.xml``

Implementation
--------------

HDL Device Worker
^^^^^^^^^^^^^^^^^

**Devices** are hardware elements that are locally attached to the processor of the platform. They are controlled by special workers called **device workers** (analogous to "device drivers"), and usually act as sources or sinks for data into or out of the system, and thus can be used for inputs and outputs for a component-based application running on that system.

[`OpenCPI Platform Development Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_Platform_Development_Guide.pdf>`_].

The HDL Device Worker code and documentation is located here: ``hdl/devices/ads7038.hdl/ads7038-worker.rst``.

#. Review the ADS7038 datasheet to capture properties/types.

   - Review the device data sheet to identify all device registers. Identify each registers data-type, and its accessability.

   - Take note of the default register values to reference during the ``pre-proxy`` phase of development.

   - Take note of the SPI clock frequency that will be used to drive the device.

#. Review the ADS7038 datasheet for the SPI interface timing diagrams, this should be used for designing the VHDL SPI Primitive.

   The SPI timing diagrams below are used to create the ``spi_ads7038.vhd``. Use these timing diagrams to compare the contents of the ``spi_ads7038.vhd`` file to create the SPI VHDL state-machine used by the device.

   - Register Write Timing Diagram

.. figure:: ./figures/ads7038_write_timing_diagram.png

..

   - Register Read Timing Diagram

.. figure:: ./figures/ads7038_read_timing_diagram.png

..

#. Create Device Worker

   #. Create the ads7038 Device Worker XML ``ads7038.xml``

      The ads7038 Device Worker is located: ``hdl/devices/ads7038.hdl/ads7038.xml``. Reference this file during the explanation of this section. Some, not all of the Device Worker XML functionality will be defined below.

      - ``FirstRawProperty``: Defines the first property that is to be accessed via the Raw Properties Port. This ``FirstRawProperty`` will be the first ads7038 register ``system_status``.

      #. Calculate/Set Control Interface Timeout value:

         ``controlinterface Timeout=<value>`` : Defines the minimum number of control clock cycles that should be allowed for the worker to complete control operations or property access opertaions.

      #. Create the Control Plane (CP), and SPI Clock (SPI_CLK) frequencies that are implemented within the ``ads7038.vhd``. The ``ads7038.vhd`` file will be created in a later step.

         - ``<property name="CP_CLK_FREQ_HZ_p"  type="ulong" parameter="1" default="100000000"/>`` - This property defines the Control Plane clock frequency. This value is used to calculate the dividor for the SPI clock.

         - ``<property name="SPI_CLK_FREQ_HZ_p" type="ulong" parameter="1" default="5000000"/>`` - This property defines the SPI clock frequency. This SPI clock frequency is defined within the ADS7038 datasheet.

      #.  Create Property registers per the datasheet.

         ``<property name="system_status" type="uchar" volatile="true" writable="true"/>`` - This property is defined in the ADS7038 datasheet on Page 30. This register contains operational code that controls some basic device functionality.

         - ``<property name="system_status"`` - Defines the device register name.

         - ``type="uchar"`` - Defines the 8 bit length of the device register.

         - ``volatile="true"`` - The volatile attribute specifies that the device may change the value after the application starts during execution. Property reads of this register are explicitly derived from the device (**Not Cached**).

         - ``writable="true"`` - The writable attribute requires that the worker accept and implement dynamic runtime changes in the property's value. The property can be written to.

   #. Create the ads7038 Device Worker SPI primitive VHDL ``spi_ads7038.vhd``

      The ``spi_ads7038.vhd`` module defines the SPI state machine based off of the Timing Diagrams within the device data-sheet.

      #. TODO: Add more information in this section?

      #. VHDL: Adjust raw property address assignments for uchar property accessing.

         - The ``ads7038.vhd`` implements the functionality of the ``spi_ads7038.vhd`` module. This file handles the address mapping for the ``ads7038`` device. It is responsible for delegating the raw property values:

            - ``props_in.raw.address`` - Defines the raw properties address values for the device.

            - ``props_out.raw.data`` - Propogates write data that the user wishes to write to the device using the SDIO pin of the SPI bus.

            - ``props_in.raw.data`` - Propogates read data from the device over the SDIO pin of the SPI bus.

            - ``props_out.raw.done`` - Defines the done flag for the SPI state machine.

            - ``props_in.raw.is_write`` - Defines the raw property write flag during a write execution.

            - ``props_in.raw.is_read`` - Defines the raw property write flag during a read execution.

   #. Create the ads7038 Device Worker VHDL ``ads7038.vhd`` which utilizes the ``spi_ads7038.vhd`` SPI primitive

      #. TODO: Add more information in this section?

   #. Create the ads7038 Device Worker build XML ``ads7038-build.xml`` (optional)

      The optional build configuration file describes the various ways it should be currently built. The build configuration file narrows down the potential large number of ways the worker might be build (for different combinations of parameter values or targeting different platforms), to what will actually be built. When it is not present, the worker is built using th default values of parameter properties.

      The use cases for this file include:

         - Specifying useful combinations of comple-time parameters for unit testing.

         - Specifying know currently required combinations of compile-time parameters for applications.

         - Limiting platforms to build for temporary convenience rather than an expression of "what platforms are viable", which is already specified in the OWD.

      ``ads7038-build.xml`` File Outline::

         <build>
           <configuration id='0'>
           </configuration>
           <configuration id='1'>
             <parameter name='VIVADO_ILA_p' value='true'/>
           </configuration>
           <configuration id='2'>
             <parameter name='PROXY_TEST_p' value='true'/>
           </configuration>
         </build>

      ..

         - ``id='0'`` - This is the default configuration of the Device Worker.

         - ``id='1'`` - This signals to the ``ads7038.vhd`` to implement the ``VIVADO_ILA_p`` parameter. With this parameter selected the Device Worker will implement a ``debug`` purposed Vivado ILA for signal inspection.

         - ``id='2'`` - This signals to the ``ads7038.vhd`` to implement the ``PROXY_TEST_p`` parameter. With this parameter selected the Device Worker will implement an HDL memory mappeded device worker. This is used to test the proxy functionality without the need of the device hardware.

   #. Create the ads7038 Device Worker ``signals.vhd`` file

      #. TODO: Add more information in this section?

   #. Create the ads7038 Device Worker VHDL PKG ``ads7038_pkg.vhd``

      #. TODO: Add more information in this section?

   #. (Optional) Create the ads7038 Device Worker Proxy test ``ads7038_proxy_test.vhd``

      #. TODO: Add more information in this section?

   #. (Optional) Create the ads7038 Device Worker SPI Primitive Test Bench VHDL ``tb_spi_ads7038.vhd``

      #. TODO: Add more information in this section?

   #. Makefile: Update as needed.

      #. TODO: Add more information in this section?

   #. Create documentation for the Device Worker.

      #. TODO: Add more information in this section?

Pre Proxy
^^^^^^^^^

A device ``pre-proxy`` is an optional step that tests the basic functioanlity of the ``HDL Device Worker``, specifically, the SPI state-machine functionality,device register accessablity, and the device default register values. The ``pre-proxy`` gives the user the ability to test the ``HDL Device Worker`` without  introducing complexity of the ``RCC Worker``. Once this functionality has been tested, the user can "more comfortably" move onto development of the ``RCC Worker``.

The "Pre-Proxy" programming scirpt is located in the ``applications/pre_proxy/program.sh`` and defines some basic ``ocpihdl -x get 3 <register>`` and ``ocpihdl set 3 <register>`` commands. The following lines **must** be included at the top of the script to properly initialize the device and setup the register timeout before ``ocpihdl get/set`` commands can be executed::

      # Unreset Worker
      ocpihdl wunreset 3

      # Set the control register timeout
      ocpihdl wwctl 3 0x80000012

      # Start Worker
      ocpihdl wop 3 start

   ..

#. Create a ``Pre-Proxy`` programming script

   #. Test ``get`` functionality of the ``HDL Device Worker``

      Perform ``get`` commands ``ocpihdl -x get 3 register_name`` for each of the registers that have been defined in the ``Device Worker``. Be sure that each of the get commands are returning the appropriate default values outlined in the device data-sheet. For example

   ::

      # system_status Register
      ocpihdl -x get 3 system_status

      # general_cfg Register
      ocpihdl -x get general_cfg

      # data_cfg Regsiter
      ocpihdl -x get 3 data_cfg

   ..

   - stdout of the pre-proxy ``get`` commands::

      Worker 3 on device pl:0: reset deasserted, was asserted
      Worker 3 on device pl:0: writing control register value: 0x80000012
      Worker 3 on device pl:0: the 'start' control operation was performed with result 'success' (0xc0de4201)
      Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
      7        system_status: 0x81
      Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
      8          general_cfg: 0x0
      Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
      9             data_cfg: 0x0

   ..

   #. Test ``set`` functionality of the ``HDL Device Worker``

      Perform ``set`` commands ``ocpihdl set 3 register_name 0xVALUE`` for each of the registers that have been defined in the ``Device worker``. After the initial ``get`` command, which reads the defualt register value, perform a ``set`` command to set a new register value. After the ``set`` command perform an additional ``get`` command to read the new value that was just ``set``. For example

      ::

         # system_status Register
         ocpihdl -x get 3 system_status
         ocpihdl -x set 3 system_status 0x0001
         ocpihdl -x get 3 system_status

         # general_cfg Register
         ocpihdl -x get 3 general_cfg
         ocpihdl -x set 3 general_cfg 0x0002
         ocpihdl -x get 3 general_cfg

         # data_cfg Register
         ocpihdl -x get 3 data_cfg
         ocpihdl -x set 3 data_cfg 0x0003
         ocpihdl -x get 3 data_cfg

      ..

   - stdout of the pre-proxy ``set`` commands

      ::

         Worker 3 on device pl:0: reset deasserted, was asserted
         Worker 3 on device pl:0: writing control register value: 0x80000012
         Worker 3 on device pl:0: the 'start' control operation was performed with result 'success' (0xc0de4201)
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           7        system_status: 0x81
         Setting the system_status property to '0x0000' on instance 'c/FMC_PL_ads7038'
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           7        system_status: 0x0
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           8          general_cfg: 0x0
         Setting the general_cfg property to '0x0001' on instance 'c/FMC_PL_ads7038'
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           8          general_cfg: 0x1
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           9             data_cfg: 0x0
         Setting the data_cfg property to '0x0002' on instance 'c/FMC_PL_ads7038'
           Instance c/FMC_PL_ads7038 of io worker ads7038-2 (spec ocpi.osp.hitech_global.devices.ads7038) with index 3
           9             data_cfg: 0x2

      ..

   - Once the "Pre-Proxy" programming script is working as expected, the user can move on to creating the Device Proxy.

Sub-device Worker
^^^^^^^^^^^^^^^^^

#TODO

Device Proxy
^^^^^^^^^^^^

A **device proxy** is a software worker (RCC/C++) that is specifically paired with a device worker in order to translate a higher level control interface for a class of devices into the lower level actions required on a specific device.

`OpenCPI Platform Development Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_Platform_Development_Guide.pdf>`_

The Device Proxy code and documentation is located here: ``hdl/devices/ads7038_proxy.rcc/ads7038_proxy-worker.rst``.

#. Create Device Proxy

   #. Create the ads7038 Device Proxy XML ``ads7038_proxy-rcc.xml``

      The ``ads7038_proxy-rcc.xml`` contains multiple examples of creating a "higher-level" of abstraction and will be explained here.

      #. A combination ``struct`` and ``arraylength``  Proxy Property

         ::

            <property name="config_regs"     arraylength="8" writesync="true" type="struct" writable="true">
              <member name="pin_cfg"         type="bool"     default="false"/>
              <member name="gpio_cfg"        type="bool"     default="false"/>
              <member name="gpo_drive_cfg"   type="bool"     default="false"/>
              <member name="gpo_value"       type="bool"     default="false"/>
              <member name="alert_ch_sel"    type="bool"     default="false"/>
              <member name="event_rgn"       type="bool"     default="false"/>
            </property>

         ..

         - Each of the member properties (pin_cfg, gpio_cfg, gpo_drive_cfg, gpo_value, alert_ch_sel, event_rgn) of this proxy property (config_regs) represent HDL Device Worker registers that are responsible for various configuration selections of the 8 channel ADC/GPIO of the device. They have been grouped together so that during implementation of the Application, the user can configure only the channel(s) and configuration setting(s) that they care about.

         - ``arraylength="8"`` - Defines an array type property which represents the 8 channels of each configuration register (member property) of the ADC/GPIO.

         - ``type="struct"`` - Defines that the ``config_regs`` proxy property will contain some number of property members as part of its structure.

         - ``writesync="true"`` - Defines the write functionality of the RCC Proxy. When the application "Writes" this proxy property, that is when the user defines a new non-default proxy property value within the device application, the proxy is alerted, and the ``RCCResult config_regs_written()`` class method within the ``ads7038.cc`` RCC Proxy is executed.

         - ``writable="true"`` - This proxy property can be written to.

         - ``member name=`` - Defines a new Proxy Property member as implied by the ``type="struct"`` proxy property attribute.

         - ``type="bool"`` - Defines that the member property is of type bool. This represents a single bit of the HDL Worker equivalent register. Each register defines some configuration selection of the 8 channel ADC/GPIO device, each ``bool`` value represents flag (1 = true or 0 = false) that toggles this selection for a given channel::

            pin_cfg       [8] = [0|1|2|3|4|5|6|7] - Configure device channesl AIN / GPIO [7:0]  as analog inputs (0) or GPIOs (1). (Default 0)
            gpio_cfg      [8] = [0|1|2|3|4|5|6|7] - Configure GPIO [7:0] as either digital inputs (0) or digital outputs (1). (Default 0)
            gpo_drive_cfg [8] = [0|1|2|3|4|5|6|7] - Configure digital outputs [7:0] as open-drain (0) or push-pull outputs (1). (Default 0)
            gpo_value     [8] = [0|1|2|3|4|5|6|7] - Logic level to be set on digital outputs GPO [7:0]. (Default 0)
            alert_ch_sel  [8] = [0|1|2|3|4|5|6|7] - Select channels for which the alert flags can assert the internal ALERT signal. (Default 0)
            event_rgn     [8] = [0|1|2|3|4|5|6|7] - Choice of region used in monitoring analog/digital inputs CH[7:0]. (Default 0)

         - ``default="false"`` Defines the default value for a given bit of the member property.

      #. A ``struct`` Proxy Property

         ::

            <property name="autonomous_mode" writesync="true" type="struct" writable="true">
              <member name="mode"            type="bool"      default="true"/>
              <member name="auto_seq_ch_sel" type="uchar"     default="0x00"/>
              <member name="osc_sel"         type="bool"      default="false"/>
              <member name="clk_div"         type="uchar"     default="0x00"/> <!-- 4 Bit range -->
              <member name="conv_on_err"     type="bool"      default="false"/>
              <member name="stats_enable"    type="bool"      default="false"/>
              <member name="oversampling"    type="uchar"     default="0x00"/> <!-- 3 Bit range -->
            </property>

         ..

         - Autonomous mode is a a specific mode for the device and is outlined within the data-sheet. **Currently this is the only mode supported for the device**. The member properties within the Autonomous mode directly represent registers that are responsible for initializing and configuring the autonomous mode of the device.

         - Unlike the ``config_regs`` property, the ``autonomous_mode`` property is not an ``arraylength`` property but is a ``struct`` property which contains relevant member properties.

         - Unlike the ``config_regs`` property, the ``autonomous_mode`` property contains both bool and uchar property types.

      #. ``arraylength`` Proxy Properties

         ::

            <property name="hysteresis"     writesync="true" type="uchar"  arraylength="8" writable="true"/>
            <property name="high_threshold" writesync="true" type="ushort" arraylength="8" writable="true"/>
            <property name="event_count"    writesync="true" type="uchar"  arraylength="8" writable="true"/>
            <property name="low_threshold"  writesync="true" type="ushort" arraylength="8" writable="true"/>

         ..

         - Each of these proxy properties are ``arraylength="8"`` properties which represent threhsold values that the user can setup to monitor the ADC input channels. Each array member element contains either a ``uchar`` or ``ushort`` value.

         - The ``high_threshold`` and ``low_threshold`` properties represent two HDL Worker properties (registers). For example,  the ``high_threshold`` proxy property represents the HIGH_TH_CHx register (MSB) and a portion of the HYSTERESIS_CHx (LSB) register, which together represent a 12b High_threshold value for each of the channels.

         - The ``hysteresis`` proxy property represents the lower nibble of the HYSTERESIS_CHx register.

         - The ``event_count`` proxy property represents the lower nibble of the EVENT_COUNT_CHx register.

         - This functionality allows the user to set these values and the proxy will take care of setting the appropriate device registers with the correct MSB, and LSB along with the particular nibble that the user set for the hysteresis and event_count proxy property value. These values are set in the application. The proxy will appropriately check the values that the user sets at the application level, if they happen to exceed the 12b for high/low threshold or 4b for hysteresis/event_count, the proxy will notify the user (OCPI_LOG_LEVEL=8) to set an appropriate value.

      #. Read Minimum, Read Maximum, Read Recent Proxy Properties

         ::

            <property name="read_min_val"    readsync="true" type="ushort" arraylength="8" volatile="true"/>
            <property name="read_max_val"    readsync="true" type="ushort" arraylength="8" volatile="true"/>
            <property name="read_recent_val" readsync="true" type="ushort" arraylength="8" volatile="true"/>

         ..

         - ``readsync="true"`` - Defines the read functionality of the RCC Proxy Property. When the application "reads" this proxy property the proxy is alerted and the ``RCCResult read_max_val_read()`` class method within the ``ads7038.cc`` RCC Proxy is executed. This method is written so that when this Proxy Property is read, it will read both the ``recent_chx_msb()`` and the ``recent_chx_lsb`` and do the appropriate bitwise logic. This way the user only needs to signify that they want to read one of these values; the proxy will then initiate the appropriate logic to display that value to the user. This goes for the ``read_min_val`` and ``read_max_val`` proxy properties alike.

         - Each of these proxy properties are ``arraylength="8"`` properties which represent read-only ADC values for each of the ADC channels that are configured. With the ``stats_enabled`` bool member property of the ``autonomous_mode`` proxy property set, these values represent the HDL Worker registers that are responsible for collecting ADC input data from any ADC configured channel.

   #. Create the ads7038 Device Proxy C++ ``ads7038_proxy.cc``

      The fundamental implementation of the Device Proxy is to create a "higher-level" of abstraction of the devices register set. This section will highlight each of the Class Methods that have been created for implementing this device and the reasoning behind it's creation.

      **Writesync Properties** - The <property>_written() method implies that the <property> is a writesync property (``writesync="true"``). When the user set(s) non-default value(s) for any writesync property or member-property in the device application, this method will collect all updated value(s) (non-default) from the application for each of its members and set the appropriate device register value.

      #. ``RCCResult config_regs_written()`` method - When prompted this method gives the user the ability to set register configuration values that pertain to their design. This ease of use design groups all channel configuration registers together so the user can easily define the channel configuration that they want to implement.

      #. ``RCCResult autonomous_mode_written()`` method - When prompted this method groups together any ``autonomous mode`` specific funtionality using the member properties. These member properties reflect information that is used to implement the ``autonomous mode`` of the device.

      #. ``RCCResult hysteresis_written()`` method - When prompted this method does bitwise logic to configure the LSB nibble of the ``HYSTERESIS_CHx`` device register. Each of the user value application enteries are checked for a valid range. If any value the user attempts to set exceeds the permissable range value (4b), no values are written and a log stdout (OCPI_LOG_LEVEL=8) error is written to warn the user which value(s) is out of range.

      #. ``RCCResult high_threshold_written()`` method - When prompted this method does bitwise logic to configure the MSB nibble of the ``HYSTERESIS_CHx`` device register and the ``HIGH_TH_CHx`` device register. Each of the user value application enteries are checked for a valid range. If any value the user attempts to set exceeds the permissable range value (12b), no values are written and a log stdout (OCPI_LOG_LEVEL=8) error is written to warn the user which value(s) is out of range.

      #. ``RCCResult event_count_written()`` method - When prompted this method does bitwise logic to configure the LSB nibble of the ``EVENT_COUNT_CHx`` device register. Each of the user value application enteries are checked for a valid range. If any value the user attempts to set exceeds the permissable range value (4b), no values are written and a log stdout (OCPI_LOG_LEVEL=8) error is written to warn the user which value(s) is out of range.

      #. ``RCCResult low_threshold_written()`` method - When prompted this method does bitwise logic to configure the MSB nibble of the ``EVENT_COUNT_CHx`` device register and the ``LOW_TH_CHx`` device register. Each of the user value application enteries are checked for a valid range. If any value the user attempts to set exceeds the permissable range value (12b), no values are written and a log stdout (OCPI_LOG_LEVEL=8) error is written to warn the user which value(s) is out of range.

      **Writesync Properties** - The <property>_read() method implies that the <property> is a readsync property (``readsync="true"``). When the user requests a value for any readsync property or member-property in the device application, this method will read the appropriate HDL Worker device register(s) value.

      #. ``RCCResult read_min_val_read()`` method - When prompted this method assigns value to the ``read_min_val[x]`` proxy property. The value assigned is determined by performing bitwise logic to the read values of the ``MIN_CHx_MSB`` and ``MIN_CHx_LSB`` device registers.

      #. ``RCCResult read_max_val_read()`` method - When prompted this method assigns value to the ``read_max_val[x]`` proxy property. The value assigned is determined by performing bitwise logic to the read values of the ``MAX_CHx_MSB`` and ``MAX_CHx_LSB`` device registers.

      #. ``RCCResult read_recent_val_read()`` method - When prompted this method assigns value to the ``read_recent_val[x]`` proxy property. The value assigned is determined by performing bitwise logic to the read values of the ``RECENT_CHx_MSB`` and ``RECENT_CHx_LSB`` device registers.

      **Property Access** - Proxy Property and HDL Property (register) access examples:

      #. Example of how to access an arraylength proxy property

      ::

         properties().hysteresis[0] - Access the proxy property 0th element value of the hysteresis arraylength=true property.

      ..

      #. Example of how to access a member of an arraylength proxy property

      ::

         properties().config_regs[0].pin_cfg - Access the proxy property 0th element of the pin_cfg member proxy property.

      ..

      #. Example of how to access an HDL Worker property (register) value

      ::

         slave.get_hysteresis_ch0() - Access the register value of the hysteresis_ch0 register.

      ..

      #. Example of how to set an HDL Worker property (register) value

      ::

         slave.set_hysteresis_ch0(VALUE) - Set the resgier value of the hysteresis_ch0 register.

      ..

#.  Makefile: Update as needed.

#. Create documentation for the Device Proxy.

Application
^^^^^^^^^^^

An **application** is an assembly of configured and connected components. Each component in the assembly indicates that, at runtime, some implementation - a worker binary - must be found for this component and an executable runtime instance must be created from this binary. Each component in the assembly can be assigned initial (startup) property values.

`OpenCPI User Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_User_Guide.pdf>`_

#. Create Application

   #. How to assign values to the ``config_regs`` proxy property and its ``arraylength="8"`` implications:

      The member properties of the ``config_regs`` proxy property are boolean flags that enable or disable various features for the ADC/GPIO channels. While the code example above is explicitly setting up all of the 8 ADC/GPIO channels, the user can also setup an individual channel or a certain number of channels while leaving other channels to their default values. This archetecture gives the user the ability to easliy setup only the channels that they care about for a given application.

      ::

         Sudo Code:
         ----------
         <property name="config_regs"
                   value="{pin_cfg[0] value, gpio_cfg[0] value, gpo_drive_cfg[0] value, gpo_value[0] value,
                           alert_ch_sel[0] value, alert_ch_sel[0] value, event_rgn[0] value},

                          {pin_cfg[1] value, gpio_cfg[1] value, gpo_drive_cfg[1] value, gpo_value[1] value,
                           alert_ch_sel[1] value, alert_ch_sel[1] value, event_rgn[1] value},

                          {pin_cfg[2] value, gpio_cfg[2] value, gpo_drive_cfg[2] value, gpo_value[2] value,
                           alert_ch_sel[2] value, alert_ch_sel[2] value, event_rgn[2] value},

                          {pin_cfg[3] value, gpio_cfg[3] value, gpo_drive_cfg[3] value, gpo_value[3] value,
                           alert_ch_sel[3] value, alert_ch_sel[3] value, event_rgn[3] value},

                          {pin_cfg[4] value, gpio_cfg[4] value, gpo_drive_cfg[4] value, gpo_value[4] value,
                           alert_ch_sel[4] value, alert_ch_sel[4] value, event_rgn[4] value},

                          {pin_cfg[5] value, gpio_cfg[5] value, gpo_drive_cfg[5] value, gpo_value[5] value,
                           alert_ch_sel[5] value, alert_ch_sel[5] value, event_rgn[5] value},

                          {pin_cfg[6] value, gpio_cfg[6] value, gpo_drive_cfg[6] value, gpo_value[6] value,
                           alert_ch_sel[6] value, alert_ch_sel[6] value, event_rgn[6] value},

                          {pin_cfg[7] value, gpio_cfg[7] value, gpo_drive_cfg[7] value, gpo_value[7] value,
                           alert_ch_sel[7] value, alert_ch_sel[7] value, event_rgn[7] value}"/>

         Actual Code:
         ------------
         <property name="config_regs"
                   value="{pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true},

                          {pin_cfg true, gpio_cfg false, gpo_drive_cfg true, gpo_value false,
                           alert_ch_sel true, alert_ch_sel false, event_rgn true}"/>
       ..

   #. How to assign values to the ``autonomous_mode`` proxy property and its member properties:

      The member property ``mode`` does **not** represent an HDL Property (register) but is used by the proxy to setup the device for autonomous_mode. The other property members represent portions of specific HDL Properties (registers). For example, the ``conv_on_error``, ``conv_mode``, ``osc_sel`` and ``clk_div`` member properties comprise the ``opmode_cfg`` HDL Property (regsiter). The user can specify values for each of these member properties and the proxy will assign value to the ``opmode_cfg`` HDL Propert (register).

      ::

         Sudo Code:
         -----------
         <property name="autonomous_mode"
                   value="member0_name value, member1_name value, member2_name value, member3_name value,
                          member4_name value, member5_name value, member6_name value"/>

         Actual Code:
         ------------
         <property name="autonomous_mode"
                   value="mode true, auto_seq_ch_sel 0xAA, clk_div 0x02,
                          conv_on_err false, osc_sel false, stats_enable true, oversampling 0x07"/>

      ..



   #. How to assign values to the ``high_threshold`` proxy property:

      This functionality also applies to the ``hysteresis``, ``low_threshold``, and ``event_count`` proxy properties.

      ::

         Sudo Code:
         ----------
         <property name="high_threshold"
                   value="ch0_val, ch1_val, ch2_val, ch3_val, ch4_val, ch5_val, ch6_val, ch7_val"/>

         Actual Code:
         ------------
         <property name="high_threshold"
                   value="0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07"/>

      ..

      The member value sets the high_threshold channel value of a given device register. The ``ads7038.cc`` then collects these settings, and sets the device registers accordingly. The example above sets the following device registers within the ``ads7038.cc``::

         - ``slave.set_high_th_ch0(0x00);``

         - ``slave.set_high_th_ch1(0x01);``

         - ``slave.set_high_th_ch1(0x02);``

         - ``slave.set_high_th_ch1(0x03);``

         - ``slave.set_high_th_ch1(0x04);``

         - ``slave.set_high_th_ch1(0x05);``

         - ``slave.set_high_th_ch1(0x06);``

      #. How Read-Only Proxy properties work in the context of an application:

         Since these properties are read-only by nature, the application does not and cannot **set** or **assign** value to these properties. Since they assign the ``readsync="true"`` attribute, the ACI can access or trigger the ``RCC <property_name>_read()`` method to read them. This will be described in greater detail in the ACI portion of this guide.

         ::

            <property name="read_min_val"    readsync="true" type="ushort" arraylength="8" volatile="true"/>
            <property name="read_max_val"    readsync="true" type="ushort" arraylength="8" volatile="true"/>
            <property name="read_recent_val" readsync="true" type="ushort" arraylength="8" volatile="true"/>

         ..


#.  Makefile: Update as needed.

#. Create documentation for the application.

ACI
^^^

We use the term control software to describe software that launches and controls OpenCPI applications. This is either the standard utility program, ocpirun, or custom C++ programs that perform the same function embedded inside them. Such custom programs use the **Application Control Interface (ACI)**, an application launch and control API described in the **OpenCPI Application Development Guide**.

`OpenCPI Application Development Guide <https://opencpi.gitlab.io/releases/v2.5.0-beta.1/docs/OpenCPI_Component_Development_Guide.pdf>`_

The ads7038 ACI is located: ``applications/zrf8_48dr_ads7038_test_app/zrf8_48dr_ads7038_test_app.cc``

- When performing an ``ocpirun <application.xml>`` the application is run once, and the device registers are queried once. The additional ACI layer allows the user to dynamically access devices registers or proxy properties several times.

#. Create an OpenCPI Application Control Interface

   The user must determine if there is a need to implement an ACI for their target device. The user may not need to create an ACI if a device application satisfies the need of the users implementation. If a user only needs to read device register values or proxy properties one time, then there may not be a need to create an ACI. However, if the user needs dynamic/programmatic functionality of the device that is not possible with a device application, then an ACI layer may be necessary.

   #. Determine any dynamic/programmatic functionality that the device needs to perform that is not possible with a device application.

      A basic ACI was derived for the ads7038 device. The ACI's functionality is to read the ``read_min_val``, ``read_max_val``, and ``read_recent_val`` based on information gathered from the ``auto_seq_ch_sel`` and ``stats_enable`` proxy properties.

      When the ACI is executed it determines which ADC analog channels are enabled by interrogating the ``auto_seq_ch_sel`` proxy property. The ``auto_seq_ch_sel`` proxy property is responsible for selecting analog input channels AIN[7:0] for auto sequencing mode. Once the ACI determines which channels are setup for auto sequencing mode, it determines if the ``stats_enable`` proxy property boolean value is set. The ``stats_enable`` boolean is responsible for enabling (1) or disabling (0) the  minimum, maximum, and recent value registers to be updated. With this information the ACI can then extract analog channel specific data across the ``read_min_val``, ``read_max_val`` and ``read_recent_val`` proxy property registers.

HDL Platform Worker
^^^^^^^^^^^^^^^^^^^

**HDL Platform Worker**: A specific type of HDL worker providing infrastructure for implementing control/data interfaces to devices and interconnects external to the FPGA or simulator (e.g. PCI Express, Clocks).

`OpenCPI Platform Development Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_Platform_Development_Guide.pdf>`_

For any Device Worker to be available for inclusion in a bitstream, it must be declared in the Platform Worker OWD and its signals tied to FPGA pins.

#. Declare Device/Subdevice Workers in the Platform Worker OWD

TODO: Add more info

HDL Assembly
^^^^^^^^^^^^

**HDL Assembly**: A composition of connected HDL workers that are built into a complete FPGA configuration bitstream, acting as an OpenCPI artifact. The resulting bitstream is executed on an FPGA to implement some part or all of (the components of) the overall OpenCPI application.

For testing the Device Worker, an ``empty`` assembly is implemented. As the name implies the assembly is void of Application Workers, therefore the Device Workers must be instanced using a Container XML file.

The following is a description of the files needed in support of an ``empty`` assembly:

#. Create the ads7038 Empty Assembly ``empty.xml``

   ``empty.xml``: Is the OpenCPI Hardware Assembly Description (OHAD) file. It instances all of the Application Workers and their connections of the application or portion of the application. For the ``empty`` assembly, the special ``nothing`` worker is instance indicating that the assembly is actually void of any workers.

#. Create the ads7038 Container ``cnt_zrf8_48dr_ads7038.xml``

   ``cnt_zrf8_48dr_ads7038.xml``: Is the Container file.

      - **config, only, constraints**: Are top level attributes that provide the ability to declare which Platform Configuration, Platform, and constraints to build against, respectively.

      - **<device name='ads7038'/>**: Instances a Device Worker(s) that are to be included. During the build process, the Subdevice Worker that supports the combination of all Device Workers listed in the Container file will be located and included in the build.

   * **hdl/assemblies/empty/Makefile**: Supports restricting the building of the ``empty`` assembly to specific Containers via the **Containers=** make directive.

Pre-Hardware Proxy Testing
--------------------------

This configuration method can be setup to construct the ``ads7038.vhd`` in a way that gives the user the ability to test the Proxy outside of the HDL Device.

TODO: ADAM


Testing
-------

The ``Testing`` stage of development encapsulates and tests the ``research``, ``check-list`` and ``implementation`` phases of development. After the ``application`` has first been tested, the developer may need to re-perform both the ``research``, ``check-list``, and ``implementation`` phases again, until the desired outcome is reached when running the test application.

#. Setup embedded platform

   #. For you choice of Standalone, Network or Server Mode.

   #. Setup the OCPI_LIBRARY_PATH for locating run-time artifacts.

#. Application execution

   #. Execute the app for 1 sec and dump the property values.

      ``ocpirun -v -d -x -t 1 zrf8_48dr_ads7038_test_app.xml``

      - STDOUT below

#. ACI Execution

   #. Build the ACI Artifacts (On host)

      ``cd ocpi.osp.hitech-global/``

      ``ocpidev build --rcc-platform xilinx21_1_aarch64``

      ``scp -r applications/zrf8_48dr_ads7038_test_app <device>:/home/root/opencpi/applications/``

   #. Run the ACI (On zrf8_48dr)

      ``cd /home/root/opencpi/applications/zrf8_48dr_ads7038_test_app/``

      ``./target-xilinx21_1_aarch64/zrf8_48dr_ads7038_test_app``

      - STDOUT below


#. ACI STDOUT

   ::

      % ./target-xilinx21_1_aarch64/zrf8_48dr_ads7038_test_app
      Channel [7] Minimum Value Read: 0x65535
      Channel [7] Maximum Value Read: 0x0
      Channel [7] Recent  Value Read: 0x0
      Channel [6] Minimum Value Read: 0x65535
      Channel [6] Maximum Value Read: 0x0
      Channel [6] Recent  Value Read: 0x0
      Channel [5] Minimum Value Read: 0x65535
      Channel [5] Maximum Value Read: 0x0
      Channel [5] Recent  Value Read: 0x0
      Channel [4] Minimum Value Read: 0x65535
      Channel [4] Maximum Value Read: 0x0
      Channel [4] Recent  Value Read: 0x0
      Channel [3] Minimum Value Read: 0x65535
      Channel [3] Maximum Value Read: 0x0
      Channel [3] Recent  Value Read: 0x0
      Channel [2] Minimum Value Read: 0x65535
      Channel [2] Maximum Value Read: 0x0
      Channel [2] Recent  Value Read: 0x0
      Channel [1] Minimum Value Read: 0x65535
      Channel [1] Maximum Value Read: 0x0
      Channel [1] Recent  Value Read: 0x0
      Channel [0] Minimum Value Read: 0x65535
      Channel [0] Maximum Value Read: 0x0
      Channel [0] Recent  Value Read: 0x0

   ..

#. Application STDOUT using ``ocpirun``

   ::

      % ocpirun -v -d -x -t 1 zrf8_48dr_ads7038_test_app.xml
      Available containers are:  0: PL:0 [model: hdl os:  platform: zrf8_48dr], 1: rcc0 [model: rcc os: linux platform: xilinx21_1_aarch64]
      Actual deployment is:
        Instance  0 ads7038_proxy (spec ocpi.osp.hitech_global.devices.ads7038_proxy) on rcc container 1: rcc0, using ads7038_proxy in /home/root/opencpi/xilinx21_1_aarch64/artifacts/ads7038_proxy.so dated Tue Mar 13 10:19:06 2018
        Instance  1 ads7038_proxy.ads7038 (spec ocpi.osp.hitech_global.devices.ads7038) on hdl container 0: PL:0, using ads7038-2/c/FMC_PL_ads7038 in /home/root/opencpi/artifacts/empty_zrf8_48dr_base_cnt_zrf8_48dr_ads7038_proxy_test.bitz dated Sat Apr  7 08:11:42 2018
      Application XML parsed and deployments (containers and artifacts) chosen [0 s 62 ms]
      Application established: containers, workers, connections all created [2 s 5 ms]
      Dump of all initial property values:
      Property   3: ads7038_proxy.gpi_value = "0x0"
      Property   4: ads7038_proxy.config_regs = "{pin_cfg false,gpio_cfg false,gpo_drive_cfg false,gpo_value false,alert_ch_sel false,event_rgn false}"
      Property   5: ads7038_proxy.autonomous_mode = "mode true,auto_seq_ch_sel 0x0,osc_sel false,clk_div 0x0,conv_on_err false,stats_enable true,oversampling 0x0"
      Property   6: ads7038_proxy.hysteresis = "0x0"
      Property   7: ads7038_proxy.high_threshold = "0xfff,0xfff,0xfff,0xfff,0xfff,0xfff,0xfff,0xfff"
      Property   8: ads7038_proxy.event_count = "0x0"
      Property   9: ads7038_proxy.low_threshold = "0x0"
      Property  10: ads7038_proxy.read_min_val = "0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff"
      Property  11: ads7038_proxy.read_max_val = "0x0"
      Property  12: ads7038_proxy.read_recent_val = "0x0"
      Property  13: ads7038_proxy.gpo_trig_event_sel = "0x0"
      Property  17: ads7038_proxy.ads7038.PROXY_TEST_p = "true" (parameter)
      Property  18: ads7038_proxy.ads7038.VIVADO_ILA_p = "false" (parameter)
      Property  19: ads7038_proxy.ads7038.CP_CLK_FREQ_HZ_p = "0x5f5e100" (parameter)
      Property  20: ads7038_proxy.ads7038.SPI_CLK_FREQ_HZ_p = "0x4c4b40" (parameter)
      Property  21: ads7038_proxy.ads7038.system_status = "0x81"
      Property  22: ads7038_proxy.ads7038.general_cfg = "0x20"
      Property  23: ads7038_proxy.ads7038.data_cfg = "0x0"
      Property  24: ads7038_proxy.ads7038.osr_cfg = "0x0"
      Property  25: ads7038_proxy.ads7038.opmode_cfg = "0x20"
      Property  26: ads7038_proxy.ads7038.pin_cfg = "0x0"
      Property  27: ads7038_proxy.ads7038.reserve_06 = "0x0"
      Property  28: ads7038_proxy.ads7038.gpio_cfg = "0x0"
      Property  29: ads7038_proxy.ads7038.reserve_08 = "0x0"
      Property  30: ads7038_proxy.ads7038.gpo_drive_cfg = "0x0"
      Property  31: ads7038_proxy.ads7038.reserve_0A = "0x0"
      Property  32: ads7038_proxy.ads7038.gpo_value = "0x0"
      Property  33: ads7038_proxy.ads7038.reserve_0C = "0x0"
      Property  34: ads7038_proxy.ads7038.gpi_value = "0x0"
      Property  35: ads7038_proxy.ads7038.reserve_0E = "0x0"
      Property  36: ads7038_proxy.ads7038.reserve_0F = "0x0"
      Property  37: ads7038_proxy.ads7038.sequence_cfg = "0x1"
      Property  38: ads7038_proxy.ads7038.channel_sel = "0x0"
      Property  39: ads7038_proxy.ads7038.auto_seq_ch_sel = "0x0"
      Property  40: ads7038_proxy.ads7038.reserve_13 = "0x0"
      Property  41: ads7038_proxy.ads7038.alert_ch_sel = "0x0"
      Property  42: ads7038_proxy.ads7038.reserve_15 = "0x0"
      Property  43: ads7038_proxy.ads7038.alert_map = "0x0"
      Property  44: ads7038_proxy.ads7038.alert_pin_cfg = "0x0"
      Property  45: ads7038_proxy.ads7038.event_flag = "0x0"
      Property  46: ads7038_proxy.ads7038.reserve_19 = "0x0"
      Property  47: ads7038_proxy.ads7038.event_high_flag = "0x0"
      Property  48: ads7038_proxy.ads7038.reserve_1b = "0x0"
      Property  49: ads7038_proxy.ads7038.event_low_flag = "0x0"
      Property  50: ads7038_proxy.ads7038.reserve_1d = "0x0"
      Property  51: ads7038_proxy.ads7038.event_rgn = "0x0"
      Property  52: ads7038_proxy.ads7038.reserve_1f = "0x0"
      Property  53: ads7038_proxy.ads7038.hysteresis_ch0 = "0xf0"
      Property  54: ads7038_proxy.ads7038.high_th_ch0 = "0xff"
      Property  55: ads7038_proxy.ads7038.event_count_ch0 = "0x0"
      Property  56: ads7038_proxy.ads7038.low_th_ch0 = "0x0"
      Property  57: ads7038_proxy.ads7038.hysteresis_ch1 = "0xf0"
      Property  58: ads7038_proxy.ads7038.high_th_ch1 = "0xff"
      Property  59: ads7038_proxy.ads7038.event_count_ch1 = "0x0"
      Property  60: ads7038_proxy.ads7038.low_th_ch1 = "0x0"
      Property  61: ads7038_proxy.ads7038.hysteresis_ch2 = "0xf0"
      Property  62: ads7038_proxy.ads7038.high_th_ch2 = "0xff"
      Property  63: ads7038_proxy.ads7038.event_count_ch2 = "0x0"
      Property  64: ads7038_proxy.ads7038.low_th_ch2 = "0x0"
      Property  65: ads7038_proxy.ads7038.hysteresis_ch3 = "0xf0"
      Property  66: ads7038_proxy.ads7038.high_th_ch3 = "0xff"
      Property  67: ads7038_proxy.ads7038.event_count_ch3 = "0x0"
      Property  68: ads7038_proxy.ads7038.low_th_ch3 = "0x0"
      Property  69: ads7038_proxy.ads7038.hysteresis_ch4 = "0xf0"
      Property  70: ads7038_proxy.ads7038.high_th_ch4 = "0xff"
      Property  71: ads7038_proxy.ads7038.event_count_ch4 = "0x0"
      Property  72: ads7038_proxy.ads7038.low_th_ch4 = "0x0"
      Property  73: ads7038_proxy.ads7038.hysteresis_ch5 = "0xf0"
      Property  74: ads7038_proxy.ads7038.high_th_ch5 = "0xff"
      Property  75: ads7038_proxy.ads7038.event_count_ch5 = "0x0"
      Property  76: ads7038_proxy.ads7038.low_th_ch5 = "0x0"
      Property  77: ads7038_proxy.ads7038.hysteresis_ch6 = "0xf0"
      Property  78: ads7038_proxy.ads7038.high_th_ch6 = "0xff"
      Property  79: ads7038_proxy.ads7038.event_count_ch6 = "0x0"
      Property  80: ads7038_proxy.ads7038.low_th_ch6 = "0x0"
      Property  81: ads7038_proxy.ads7038.hysteresis_ch7 = "0xf0"
      Property  82: ads7038_proxy.ads7038.high_th_ch7 = "0xff"
      Property  83: ads7038_proxy.ads7038.event_count_ch7 = "0x0"
      Property  84: ads7038_proxy.ads7038.low_th_ch7 = "0x0"
      Property  85: ads7038_proxy.ads7038.reserve_40_4d = "0x0"
      Property  86: ads7038_proxy.ads7038.reserve_4e = "0x0"
      Property  87: ads7038_proxy.ads7038.reserve_4f_5f = "0x0"
      Property  88: ads7038_proxy.ads7038.max_ch0_lsb = "0x0"
      Property  89: ads7038_proxy.ads7038.max_ch0_msb = "0x0"
      Property  90: ads7038_proxy.ads7038.max_ch1_lsb = "0x0"
      Property  91: ads7038_proxy.ads7038.max_ch1_msb = "0x0"
      Property  92: ads7038_proxy.ads7038.max_ch2_lsb = "0x0"
      Property  93: ads7038_proxy.ads7038.max_ch2_msb = "0x0"
      Property  94: ads7038_proxy.ads7038.max_ch3_lsb = "0x0"
      Property  95: ads7038_proxy.ads7038.max_ch3_msb = "0x0"
      Property  96: ads7038_proxy.ads7038.max_ch4_lsb = "0x0"
      Property  97: ads7038_proxy.ads7038.max_ch4_msb = "0x0"
      Property  98: ads7038_proxy.ads7038.max_ch5_lsb = "0x0"
      Property  99: ads7038_proxy.ads7038.max_ch5_msb = "0x0"
      Property 100: ads7038_proxy.ads7038.max_ch6_lsb = "0x0"
      Property 101: ads7038_proxy.ads7038.max_ch6_msb = "0x0"
      Property 102: ads7038_proxy.ads7038.max_ch7_lsb = "0x0"
      Property 103: ads7038_proxy.ads7038.max_ch7_msb = "0x0"
      Property 104: ads7038_proxy.ads7038.reserve_70_7f = "0x0"
      Property 105: ads7038_proxy.ads7038.min_ch0_lsb = "0xff"
      Property 106: ads7038_proxy.ads7038.min_ch0_msb = "0xff"
      Property 107: ads7038_proxy.ads7038.min_ch1_lsb = "0xff"
      Property 108: ads7038_proxy.ads7038.min_ch1_msb = "0xff"
      Property 109: ads7038_proxy.ads7038.min_ch2_lsb = "0xff"
      Property 110: ads7038_proxy.ads7038.min_ch2_msb = "0xff"
      Property 111: ads7038_proxy.ads7038.min_ch3_lsb = "0xff"
      Property 112: ads7038_proxy.ads7038.min_ch3_msb = "0xff"
      Property 113: ads7038_proxy.ads7038.min_ch4_lsb = "0xff"
      Property 114: ads7038_proxy.ads7038.min_ch4_msb = "0xff"
      Property 115: ads7038_proxy.ads7038.min_ch5_lsb = "0xff"
      Property 116: ads7038_proxy.ads7038.min_ch5_msb = "0xff"
      Property 117: ads7038_proxy.ads7038.min_ch6_lsb = "0xff"
      Property 118: ads7038_proxy.ads7038.min_ch6_msb = "0xff"
      Property 119: ads7038_proxy.ads7038.min_ch7_lsb = "0xff"
      Property 120: ads7038_proxy.ads7038.min_ch7_msb = "0xff"
      Property 121: ads7038_proxy.ads7038.reserve_90_9f = "0x0"
      Property 122: ads7038_proxy.ads7038.recent_ch0_lsb = "0x0"
      Property 123: ads7038_proxy.ads7038.recent_ch0_msb = "0x0"
      Property 124: ads7038_proxy.ads7038.recent_ch1_lsb = "0x0"
      Property 125: ads7038_proxy.ads7038.recent_ch1_msb = "0x0"
      Property 126: ads7038_proxy.ads7038.recent_ch2_lsb = "0x0"
      Property 127: ads7038_proxy.ads7038.recent_ch2_msb = "0x0"
      Property 128: ads7038_proxy.ads7038.recent_ch3_lsb = "0x0"
      Property 129: ads7038_proxy.ads7038.recent_ch3_msb = "0x0"
      Property 130: ads7038_proxy.ads7038.recent_ch4_lsb = "0x0"
      Property 131: ads7038_proxy.ads7038.recent_ch4_msb = "0x0"
      Property 132: ads7038_proxy.ads7038.recent_ch5_lsb = "0x0"
      Property 133: ads7038_proxy.ads7038.recent_ch5_msb = "0x0"
      Property 134: ads7038_proxy.ads7038.recent_ch6_lsb = "0x0"
      Property 135: ads7038_proxy.ads7038.recent_ch6_msb = "0x0"
      Property 136: ads7038_proxy.ads7038.recent_ch7_lsb = "0x0"
      Property 137: ads7038_proxy.ads7038.recent_ch7_msb = "0x0"
      Property 138: ads7038_proxy.ads7038.reserve_b0_c2 = "0x0"
      Property 139: ads7038_proxy.ads7038.gpio0_trig_event_sel = "0x0"
      Property 140: ads7038_proxy.ads7038.reserve_c4 = "0x0"
      Property 141: ads7038_proxy.ads7038.gpio1_trig_event_sel = "0x0"
      Property 142: ads7038_proxy.ads7038.reserve_c6 = "0x0"
      Property 143: ads7038_proxy.ads7038.gpio2_trig_event_sel = "0x0"
      Property 144: ads7038_proxy.ads7038.reserve_c8 = "0x0"
      Property 145: ads7038_proxy.ads7038.gpio3_trig_event_sel = "0x0"
      Property 146: ads7038_proxy.ads7038.reserve_ca = "0x0"
      Property 147: ads7038_proxy.ads7038.gpio4_trig_event_sel = "0x0"
      Property 148: ads7038_proxy.ads7038.reserve_cc = "0x0"
      Property 149: ads7038_proxy.ads7038.gpio5_trig_event_sel = "0x0"
      Property 150: ads7038_proxy.ads7038.reserve_ce = "0x0"
      Property 151: ads7038_proxy.ads7038.gpio6_trig_event_sel = "0x0"
      Property 152: ads7038_proxy.ads7038.reserve_d0 = "0x0"
      Property 153: ads7038_proxy.ads7038.gpio7_trig_event_sel = "0x0"
      Property 154: ads7038_proxy.ads7038.reserve_d2_e8 = "0x0"
      Property 155: ads7038_proxy.ads7038.gpo_trigger_cfg = "0x0"
      Property 156: ads7038_proxy.ads7038.reserve_ea = "0x0"
      Property 157: ads7038_proxy.ads7038.gpo_value_trig = "0x0"
      Application started/running [0 s 6 ms]
       [1 s 5 ms]
      ump of all final property values:
      Property   3: ads7038_proxy.gpi_value = "0x0"
      Property   4: ads7038_proxy.config_regs = "{pin_cfg false,gpio_cfg false,gpo_drive_cfg false,gpo_value false,alert_ch_sel false,event_rgn false}"
      Property   5: ads7038_proxy.autonomous_mode = "mode true,auto_seq_ch_sel 0x0,osc_sel false,clk_div 0x0,conv_on_err false,stats_enable true,oversampling 0x0"
      Property   6: ads7038_proxy.hysteresis = "0x0"
      Property   7: ads7038_proxy.high_threshold = "0xfff,0xfff,0xfff,0xfff,0xfff,0xfff,0xfff,0xfff"
      Property   8: ads7038_proxy.event_count = "0x0"
      Property   9: ads7038_proxy.low_threshold = "0x0"
      Property  10: ads7038_proxy.read_min_val = "0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff"
      Property  11: ads7038_proxy.read_max_val = "0x0"
      Property  12: ads7038_proxy.read_recent_val = "0x0"
      Property  13: ads7038_proxy.gpo_trig_event_sel = "0x0"
      Property  21: ads7038_proxy.ads7038.system_status = "0x81"
      Property  22: ads7038_proxy.ads7038.general_cfg = "0x20"
      Property  23: ads7038_proxy.ads7038.data_cfg = "0x0"
      Property  24: ads7038_proxy.ads7038.osr_cfg = "0x0"
      Property  25: ads7038_proxy.ads7038.opmode_cfg = "0x20"
      Property  26: ads7038_proxy.ads7038.pin_cfg = "0x0"
      Property  28: ads7038_proxy.ads7038.gpio_cfg = "0x0"
      Property  30: ads7038_proxy.ads7038.gpo_drive_cfg = "0x0"
      Property  32: ads7038_proxy.ads7038.gpo_value = "0x0"
      Property  34: ads7038_proxy.ads7038.gpi_value = "0x0"
      Property  37: ads7038_proxy.ads7038.sequence_cfg = "0x1"
      Property  38: ads7038_proxy.ads7038.channel_sel = "0x0"
      Property  39: ads7038_proxy.ads7038.auto_seq_ch_sel = "0x0"
      Property  41: ads7038_proxy.ads7038.alert_ch_sel = "0x0"
      Property  43: ads7038_proxy.ads7038.alert_map = "0x0"
      Property  44: ads7038_proxy.ads7038.alert_pin_cfg = "0x0"
      Property  45: ads7038_proxy.ads7038.event_flag = "0x0"
      Property  47: ads7038_proxy.ads7038.event_high_flag = "0x0"
      Property  49: ads7038_proxy.ads7038.event_low_flag = "0x0"
      Property  51: ads7038_proxy.ads7038.event_rgn = "0x0"
      Property  53: ads7038_proxy.ads7038.hysteresis_ch0 = "0xf0"
      Property  54: ads7038_proxy.ads7038.high_th_ch0 = "0xff"
      Property  55: ads7038_proxy.ads7038.event_count_ch0 = "0x0"
      Property  56: ads7038_proxy.ads7038.low_th_ch0 = "0x0"
      Property  57: ads7038_proxy.ads7038.hysteresis_ch1 = "0xf0"
      Property  58: ads7038_proxy.ads7038.high_th_ch1 = "0xff"
      Property  59: ads7038_proxy.ads7038.event_count_ch1 = "0x0"
      Property  60: ads7038_proxy.ads7038.low_th_ch1 = "0x0"
      Property  61: ads7038_proxy.ads7038.hysteresis_ch2 = "0xf0"
      Property  62: ads7038_proxy.ads7038.high_th_ch2 = "0xff"
      Property  63: ads7038_proxy.ads7038.event_count_ch2 = "0x0"
      Property  64: ads7038_proxy.ads7038.low_th_ch2 = "0x0"
      Property  65: ads7038_proxy.ads7038.hysteresis_ch3 = "0xf0"
      Property  66: ads7038_proxy.ads7038.high_th_ch3 = "0xff"
      Property  67: ads7038_proxy.ads7038.event_count_ch3 = "0x0"
      Property  68: ads7038_proxy.ads7038.low_th_ch3 = "0x0"
      Property  69: ads7038_proxy.ads7038.hysteresis_ch4 = "0xf0"
      Property  70: ads7038_proxy.ads7038.high_th_ch4 = "0xff"
      Property  71: ads7038_proxy.ads7038.event_count_ch4 = "0x0"
      Property  72: ads7038_proxy.ads7038.low_th_ch4 = "0x0"
      Property  73: ads7038_proxy.ads7038.hysteresis_ch5 = "0xf0"
      Property  74: ads7038_proxy.ads7038.high_th_ch5 = "0xff"
      Property  75: ads7038_proxy.ads7038.event_count_ch5 = "0x0"
      Property  76: ads7038_proxy.ads7038.low_th_ch5 = "0x0"
      Property  77: ads7038_proxy.ads7038.hysteresis_ch6 = "0xf0"
      Property  78: ads7038_proxy.ads7038.high_th_ch6 = "0xff"
      Property  79: ads7038_proxy.ads7038.event_count_ch6 = "0x0"
      Property  80: ads7038_proxy.ads7038.low_th_ch6 = "0x0"
      Property  81: ads7038_proxy.ads7038.hysteresis_ch7 = "0xf0"
      Property  82: ads7038_proxy.ads7038.high_th_ch7 = "0xff"
      Property  83: ads7038_proxy.ads7038.event_count_ch7 = "0x0"
      Property  84: ads7038_proxy.ads7038.low_th_ch7 = "0x0"
      Property  88: ads7038_proxy.ads7038.max_ch0_lsb = "0x0"
      Property  89: ads7038_proxy.ads7038.max_ch0_msb = "0x0"
      Property  90: ads7038_proxy.ads7038.max_ch1_lsb = "0x0"
      Property  91: ads7038_proxy.ads7038.max_ch1_msb = "0x0"
      Property  92: ads7038_proxy.ads7038.max_ch2_lsb = "0x0"
      Property  93: ads7038_proxy.ads7038.max_ch2_msb = "0x0"
      Property  94: ads7038_proxy.ads7038.max_ch3_lsb = "0x0"
      Property  95: ads7038_proxy.ads7038.max_ch3_msb = "0x0"
      Property  96: ads7038_proxy.ads7038.max_ch4_lsb = "0x0"
      Property  97: ads7038_proxy.ads7038.max_ch4_msb = "0x0"
      Property  98: ads7038_proxy.ads7038.max_ch5_lsb = "0x0"
      Property  99: ads7038_proxy.ads7038.max_ch5_msb = "0x0"
      Property 100: ads7038_proxy.ads7038.max_ch6_lsb = "0x0"
      Property 101: ads7038_proxy.ads7038.max_ch6_msb = "0x0"
      Property 102: ads7038_proxy.ads7038.max_ch7_lsb = "0x0"
      Property 103: ads7038_proxy.ads7038.max_ch7_msb = "0x0"
      Property 105: ads7038_proxy.ads7038.min_ch0_lsb = "0xff"
      Property 106: ads7038_proxy.ads7038.min_ch0_msb = "0xff"
      Property 107: ads7038_proxy.ads7038.min_ch1_lsb = "0xff"
      Property 108: ads7038_proxy.ads7038.min_ch1_msb = "0xff"
      Property 109: ads7038_proxy.ads7038.min_ch2_lsb = "0xff"
      Property 110: ads7038_proxy.ads7038.min_ch2_msb = "0xff"
      Property 111: ads7038_proxy.ads7038.min_ch3_lsb = "0xff"
      Property 112: ads7038_proxy.ads7038.min_ch3_msb = "0xff"
      Property 113: ads7038_proxy.ads7038.min_ch4_lsb = "0xff"
      Property 114: ads7038_proxy.ads7038.min_ch4_msb = "0xff"
      Property 115: ads7038_proxy.ads7038.min_ch5_lsb = "0xff"
      Property 116: ads7038_proxy.ads7038.min_ch5_msb = "0xff"
      Property 117: ads7038_proxy.ads7038.min_ch6_lsb = "0xff"
      Property 118: ads7038_proxy.ads7038.min_ch6_msb = "0xff"
      Property 119: ads7038_proxy.ads7038.min_ch7_lsb = "0xff"
      Property 120: ads7038_proxy.ads7038.min_ch7_msb = "0xff"
      Property 122: ads7038_proxy.ads7038.recent_ch0_lsb = "0x0"
      Property 123: ads7038_proxy.ads7038.recent_ch0_msb = "0x0"
      Property 124: ads7038_proxy.ads7038.recent_ch1_lsb = "0x0"
      Property 125: ads7038_proxy.ads7038.recent_ch1_msb = "0x0"
      Property 126: ads7038_proxy.ads7038.recent_ch2_lsb = "0x0"
      Property 127: ads7038_proxy.ads7038.recent_ch2_msb = "0x0"
      Property 128: ads7038_proxy.ads7038.recent_ch3_lsb = "0x0"
      Property 129: ads7038_proxy.ads7038.recent_ch3_msb = "0x0"
      Property 130: ads7038_proxy.ads7038.recent_ch4_lsb = "0x0"
      Property 131: ads7038_proxy.ads7038.recent_ch4_msb = "0x0"
      Property 132: ads7038_proxy.ads7038.recent_ch5_lsb = "0x0"
      Property 133: ads7038_proxy.ads7038.recent_ch5_msb = "0x0"
      Property 134: ads7038_proxy.ads7038.recent_ch6_lsb = "0x0"
      Property 135: ads7038_proxy.ads7038.recent_ch6_msb = "0x0"
      Property 136: ads7038_proxy.ads7038.recent_ch7_lsb = "0x0"
      Property 137: ads7038_proxy.ads7038.recent_ch7_msb = "0x0"
      Property 139: ads7038_proxy.ads7038.gpio0_trig_event_sel = "0x0"
      Property 141: ads7038_proxy.ads7038.gpio1_trig_event_sel = "0x0"
      Property 143: ads7038_proxy.ads7038.gpio2_trig_event_sel = "0x0"
      Property 145: ads7038_proxy.ads7038.gpio3_trig_event_sel = "0x0"
      Property 147: ads7038_proxy.ads7038.gpio4_trig_event_sel = "0x0"
      Property 149: ads7038_proxy.ads7038.gpio5_trig_event_sel = "0x0"
      Property 151: ads7038_proxy.ads7038.gpio6_trig_event_sel = "0x0"
      Property 153: ads7038_proxy.ads7038.gpio7_trig_event_sel = "0x0"
      Property 155: ads7038_proxy.ads7038.gpo_trigger_cfg = "0x0"
      Property 157: ads7038_proxy.ads7038.gpo_value_trig = "0x0"

   ..
