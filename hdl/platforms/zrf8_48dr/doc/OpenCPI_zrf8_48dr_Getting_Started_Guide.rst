.. OpenCPI zrf8_48dr Getting Started Guide

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

.. _OpenCPI_zrf8_48dr_Getting_Started_Guide:

OpenCPI zrf8_48dr Getting Started Guide
=======================================

.. _Revision-History:

Revision History
----------------

.. csv-table::
   :header: "Revision", "Description of Change", "Date"
   :widths: 20,20,20

   "v1.0", "Initial Release", "2/2023"

.. _Hitech-Global-Documentation:

Hitech Global Documentation
---------------------------

This document provides installation information that is specific to the ``HiTech Global zrf8_48dr`` OSP, herein ``zrf8_48dr``. It is assumed that the user understands the material and procedures that are defined in the OpenCPI documentation. To avoid reproducing redundant information in an effort of keeping this guide concise, the following documents are referenced to the tasks described in this document:

.. csv-table::
   :header: "Document", "Source", "Location"
   :widths: 20,20,20

   "ZRF8 Users-Guide", "HiTech Global", "Request from http://www.hitechglobal.com/"
   "OpenCPI Developer Guides", "OpenCPI", "https://opencpi.gitlab.io/releases/all/"
   "OpenCPI zrf8_48dr Getting Started Guide", "OpenCPI", "https://gitlab.com/opencpi/osp/ocpi.osp.hitech-global"
   "OpenCPI zrf8_48dr Developers Guide", "OpenCPI", "https://gitlab.com/opencpi/osp/ocpi.osp.hitech-global"

.. _Software-setup:

Software Setup
--------------

The following Software suites need to be installed on the host system:

   - **Vivado/SDK v2021.1 Software Suite**

   - **Petalinux v2021.1 Software Suite**

.. _Install the Framework:

Install the Framework
^^^^^^^^^^^^^^^^^^^^^

This Guide uses the following Framework branch and commit ID

   - `3420-support-for-rcc-platform-xilinx21_1_aarch64 <https://gitlab.com/opencpi/opencpi/-/tree/3420-support-for-rcc-platform-xilinx21_1_aarch64>`_

   - git commit ID - **cbcd6fa7fa477e72031181c997a5a666487b0eb9**

#. Clone the OpenCPI framework

   ``cd /home/user/``

   ``git clone https://gitlab.com/opencpi/opencpi.git``

   ``cd opencpi/``

   ``git checkout cbcd6fa7fa477e72031181c997a5a666487b0eb9``

#. Install the framework

   ``cd /home/user/opencpi/``

   ``./scripts/install-opencpi.sh --minimal``

.. _dev-Configure-a-host-terminal-for-OpenCPI-development:

Configure a host terminal for OpenCPI development
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. After the OpenCPI framework has been installed, source the OpenCPI framework setup script

   ``cd /home/user/opencpi``

   ``source cdk/opencpi-setup.sh -s``

#. Ensure that the environment is configured for the **desired version of Vivado** and its license file

   ``export OCPI_XILINX_VIVADO_VERSION=2021.1``

   ``env | grep OCPI``

   ::

      $ env | grep OCPI
      OCPI_TOOL_PLATFORM=centos7
      OCPI_PREREQUISITES_DIR=/home/user/opencpi/prerequisites
      OCPI_TOOL_OS_VERSION=c7
      OCPI_CDK_DIR=/home/user/opencpi/cdk
      OCPI_XILINX_VIVADO_VERSION=2021.1
      OCPI_ROOT_DIR=/home/user/opencpi
      OCPI_TOOL_OS=linux
      OCPI_TOOL_PLATFORM_DIR=/home/user/opencpi/project-registry/ocpi.core/exports/rcc/platforms/centos7
      OCPI_TOOL_ARCH=x86_64
      OCPI_TOOL_DIR=centos7

  ..

.. _install-the-hdl-platform:

Install the HDL Platform
^^^^^^^^^^^^^^^^^^^^^^^^

Below is an abbreviated set of steps that guide the user through the installation of the ``zrf8_48dr`` HDL Platform. This results in a single test executable application named ``testbias`` based on the ``testbias`` HDL assembly (FPGA bitstream), which are both in the ``ocpi.assets`` built-in project.

The steps provided below rely heavily on the **OpenCPI Installation Guide**.

#. Clone ``ocpi.osp.hitech-global`` project into the appropriate directory

   ``cd /home/user/opencpi/projects/osps/``

   ``git clone https://gitlab.com/opencpi/osp/ocpi.osp.hitech-global.git``

#. Register the ocpi.osp.hitech-global project

   ``cd ocpi.osp.hitech-global/``

   ``ocpidev register project``

#. Implement the ``zrf8_48dr`` part number ``xczu48dr`` in the ``opencpi/tools/include/hdl/hdl-targets.xml`` file::

     <family name='zynq_ultra' toolset='vivado' default='xczu3cg-2-sbva484e'
              parts='xczu28dr xczu9eg xczu7ev xczu3cg xczu48dr'/>

   ..

#. Implement the ``fmc_plus.xml`` card-spec within the ``projects/core/hdl/cards/specs/`` directory.

   ``cp opencpi/projects/osps/ocpi.osp.hitech-global/hdl/platforms/zrf8_48dr/doc/fmc_plus.xml opencpi/projects/core/hdl/cards/specs``

   ``cd opencpi/projects/core/``

   ``ocpidev unregister project``

   ``ocpidev register project``

#. Install ``zrf8_48dr`` HDL platform  using the ``--minmal`` flag

   ``cd opencpi/``

   ``ocpiadmin install platform zrf8_48dr --minimal``

.. _install-the-RCC-Platform:

Install the RCC Platform
^^^^^^^^^^^^^^^^^^^^^^^^

#. **Complete the** :ref:`Setup-the-Software-cross-compiler` **Section of the Appendix.**

#. Install the rcc platform ``xilinx21_1_aarch64`` using the ``--minimal`` flag

   ``cd /home/user/opencpi/``

   ``source cdk/opencpi-setup.sh -s``

   ``ocpiadmin install platform xilinx21_1_aarch64 --minimal``

.. _deploy-the-platforms:

Deploy the Platforms
^^^^^^^^^^^^^^^^^^^^

#. Deploy RCC platform onto the HDL platform

   ``ocpiadmin deploy platform xilinx21_1_aarch64 zrf8_48dr``

#. Check that the following SD-Card artifacts have been populated in the ``opencpi/cdk/zrf8_48dr/sdcard-xilinx21_1_aarch64`` directory:

   ``BOOT.BIN`` ``boot.scr`` ``Image`` ``opencpi`` ``rootfs.cpio.gz.u-boot``

.. _Hardware-setup:

Hardware Setup
--------------

.. _Device-Overview:

Device Overview
^^^^^^^^^^^^^^^

**Power Cable**

The 6-pin Molex PCIe power cable labeled PWR in the picture below, is used to apply power to the zrf8_48dr device.

**Micro-USB**

The micro-USB serial port labeled USB in the picture below, can be used to access the serial connection of the processor.

**MicroSD Card**

The MicroSD Card not shown in the picture below, is used to load the microSD card contents of the System boot artifacts.

**Ethernet Cable**

The Ethernet port in the picture below labeled ETH is used as an Ethernet connection from the development host to the device in order to utilize Server-Mode.

.. figure:: figures/zrf8_48dr_device_overview.jpg
   :alt: zrf8_48dr Device Overview
   :align: center

.. _Populating-SD-card-artifacts:

Populating SD-Card artifacts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once the ``zrf8_48dr`` HDL Platform and ``xilinx21_1_aarch64`` RCC Platform have been successfully deployed in the :ref:`deploy-the-platforms`, the following steps can be taken in order to create a valid microSD card to boot the ``zrf8_48dr`` device.

#. Complete the steps in the :ref:`creating-a-valid-sd-card` sections of the APPENDIX

#. ``cd opencpi/cdk/zrf8_48dr/sdcard-xilinx21_1_aarch64/``

#. ``sudo rm -rf /run/media/<user>/BOOT/*``

#. ``cp BOOT.BIN boot.scr Image rootfs.cpio.gz.u-boot /run/media/<user>/BOOT/``

#. ``sudo cp -RLp opencpi/ /run/media/<user>/BOOT/``

#. ``umount /dev/sda1``

- Remove the microSD card from Host

.. _Booting-the-zrf8_48dr:

Booting the zrf8_48dr
^^^^^^^^^^^^^^^^^^^^^

#. Remove power from the ``zrf8_48dr`` unit

#. With the contents provided in the :ref:`Populating-SD-card-artifacts` section, insert the microSD card into the ``zrf8_48dr`` microSD card slot

#. Attach a micro-USB serial port from the ``zrf8_48dr`` to the host (Needed for both ``Standalone-Mode`` and ``Server-Mode``)

#. Attach an ethernet cable from the ``zrf8_48dr`` to the host (Only needed for ``Server-Mode``)

#. Establish a serial connection

   ``sudo screen /dev/ttyUSB0 115200``

#. Apply Power and monitor the screen serial connection.

   - This will successfully boot the OpenCPI system image artifacts that are located on the microSD card.

.. _Configuring-the-Runtime-Environment-on-the-Platform:

Configuring the Runtime Environment on the Platform
---------------------------------------------------

After a successful boot to PetaLinux, login to the system, using **“root“** for user name and password.

Take note of the **root@zynqmp-generic** indicating that the zrf8_48dr has successfully booted using PetaLinux.

Verify that the following ``uname -a`` is observed::

   root@zynqmp-generic:~# uname -a
   Linux zynqmp-generic 5.10.0-xilinx-v2021.1 #1 SMP Tue Aug 24 05:53:21 UTC 2021 aarch64 GNU/Linux

.. _Standalone-Mode-setup:

Standalone Mode setup
^^^^^^^^^^^^^^^^^^^^^

The goal of this section is to enable the user with the ability to setup the ``Standalone Mode`` on the ``zrf8_48dr``. Success of this section is the ability to source the customized ``mysetup.sh`` script that enables the ``Standalone Mode`` and provides the ability to load bitstreams from the microSD card to the Platform Host (``zrf8_48dr``).

#. The following instructions are possible after the ``zrf8_48dr`` device has been successfully booted.

#. Create an empty ``opencpi`` directory

   ``cd /home/root/``

   ``mkdir opencpi``

#. Mount the ``/media/sd-mmcblk0p1/opencpi`` directory to the one just created in ``/home/root/opencpi/``

   ``mount /media/sd-mmcblk0p1/opencpi /home/root/opencpi``

#. On the ``zrf8_48dr`` device, browse to the OpenCPI installation directory

   ``cd /home/root/opencpi/``

#. Create the ``mysetup.sh`` for editing

   ``cp default_mysetup.sh ./mysetup.sh``

#. Source the ``mysetup.sh`` script to enable ``Standalone Mode``

   ``cd opencpi/``

   ``export OCPI_LOCAL_DIR=/home/root/opencpi``

   ``source /home/root/opencpi/mysetup.sh``

.. _Run-the-testbias-application-using-Standalone-Mode:

Run the testbias application using Standalone-Mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. On the ``zrf8_48dr`` device, browse to the applications directory

   ``cd /home/root/opencpi/applications/``

#. Configure the OpenCPI artifacts search path:

   ``export OCPI_LIBRARY_PATH=../artifacts:../xilinx21_1_aarch64/artifacts``

#. Run the testbias application

   ``ocpirun -v -d -x -m bias=hdl -p bias=biasvalue=0 testbias.xml``

.. _Server-Mode-setup:

Server Mode setup
^^^^^^^^^^^^^^^^^

**Device Setup**

#. Establish a screen connection to the device

   ``sudo screen /dev/ttyUSB0 115200``

#. Setup the IP Address

   ``ifconfig eth0 down``

   ``ifconfig eth0 add <Valid ip-address> netmask 255.255.255.0``

   ``ifconfig eth up``

**Host Setup**

#. Source the OpenCPI environment

   ``cd opencpi/``

   ``source cdk/opencpi-setup.sh -s``

#. Export the Device IP Address and valid Port

   ``export OCPI_SERVER_ADDRESSES=<Valid ip-address>:<Valid port>``

#. Export a valid socket interface

   ``export OCPI_SOCKET_INTERFACE=<Valid Socket>``

#. Load the ``sandbox`` onto the server (device):

   ``ocpiremote load -s xilinx21_1_aarch64 -w zrf8_48dr``

   ::

      $ ocpiremote load -s xilinx21_1_aarch64 -w zrf8_48dr
      Preparing remote sandbox...
      Fri Jan 27 10:53:27 UTC 2023
      Creating server package...
      Sending server package...
      Server package sent successfully
      Getting status (no server expected to be running):
      Executing remote configuration command: status
      No ocpiserve appears to be running: no pid file

   ..

#. Start the Server-Mode:

   ``ocpiremote start -b``

   ::

      $ ocpiremote start -b
      Executing remote configuration command: start -B
      The driver module is not loaded. No action was taken.
      Reloading kernel driver: 
      No reserved DMA memory found on the linux boot command line.
      Driver loaded successfully.
      Loading opencpi bitstream
      PATH=/home/root/sandbox/xilinx21_1_aarch64/bin:/home/root/sandbox/xilinx21_1_aarch64/sdk/bin:/usr/bin:/bin
      LD_LIBRARY_PATH=xilinx21_1_aarch64/sdk/lib
      VALGRIND_LIB=
      nohup ocpiserve -v -p 12345 > 20230127-105808.log
      Server (ocpiserve) started with pid: 598.  Initial log is:
      Discovery options:  discoverable: 0, loopback: 0, onlyloopback: 0
      Container server at <ANY>:12345
        Available TCP server addresses are:
          On interface eth0: 10.100.1.20:12345
      Artifacts stored/cached in the directory "artifacts", which will be retained on exit.
      Containers offered to clients are:
         0: PL:0, model: hdl, os: , osVersion: , platform: zrf8_48dr
         1: rcc0, model: rcc, os: linux, osVersion: 21_1, platform: xilinx21_1_aarch64
      --- end of server startup log success above

   ..

.. _Run-the-testbias-application-using-Server-Mode:

Run the testbias application using Server-Mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. On the host, browse to the applications directory

   ``cd /home/user/opencpi/projects/assets/applications/``

#. Configure the OpenCPI artifacts search path:

   ``export OCPI_LIBRARY_PATH=../imports/ocpi.core/artifacts/:../../assets/artifacts/``

#. Run the testbias application

   ``ocpirun -v -P bias=zrf8_48dr -p bias=biasValue=0 testbias.xml``

.. _APPENDIX:

APPENDIX
--------

.. _creating-a-valid-sd-card:

Creating a valid SD-Card
^^^^^^^^^^^^^^^^^^^^^^^^

A valid SD-Card with a ``BOOT`` partition needs to be made.

#. Be sure to save off any important information on the SD card

#. ``sudo umount /dev/sda1``

#. ``sudo fdisk /dev/sda``

#. List the current partition table

   Command (m for help): ``p``

#. Remove all current partitions

   Command (m for help): ``d``

#. Make the following selections to create two partitions

   #. New ``n``, Primary ``p``, Partition number ``1``, First sector [enter] (default),
      Last sector size [enter] (default)

#. Write table to disk and exit

   Command (m for help): ``w``

#. Uninstall and reinstall the SD Card / USB drive

#. ``sudo umount /dev/sda1``

#. ``sudo mkfs.vfat -F 32 -n BOOT /dev/sda1``

#. Uninstall and reinstall the microSD card

#. Check that the partition ``BOOT`` has been created

.. _Setup-the-Software-cross-compiler:

Setup the Software cross-compiler
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**GOAL:**

- To establish the software cross-complier

- To setup the OpenCPI functionality of the ``ZynqReleases`` and ``git`` Xilinx directories

**IMPLEMENTATION:**

The following commands are outlined in the `OpenCPI Installation Guide <https://opencpi.gitlab.io/releases/latest/docs/OpenCPI_Installation_Guide.pdf>`_

#. Setup ``Xilinx/ZynqReleases/``

   ``sudo mkdir -p /opt/Xilinx/ZynqReleases/2021.1/``

#. Implement the provided ``2021.1-zrf8_48dr-release.tar.xz`` into the ``ZynqReleases`` directory

   ``cd opencpi/projects/osps/ocpi.osp.hitech-global/hdl/platforms/zrf8_48dr/doc/code-blocks/data-plane/boot-artifacts/``

   ``sudo cp 2021.1-zrf8_48dr-release.tar.xz /opt/Xilinx/ZynqReleases/2021.1/``

   ``sudo chown -R <user>:users /opt/Xilinx/ZynqReleases``

      - Example: ``sudo chown -R smith:users /opt/Xilinx/ZynqReleases``

      - Note: This may require adjusting the permissions for ``/opt/Xilinx/ZynqReleases`` or its subdirectories

#. Setup ``Xilinx/git/``

   #. ``sudo mkdir -p /opt/Xilinx/git``

   #. Download ``linux-xlnx``

      #. ``cd ~/Downloads/``

      #. ``git clone https://github.com/Xilinx/linux-xlnx.git``

      #. ``cd linux-xlnx/``

      #. ``git checkout -b xilinx-v2021.1``

      #. ``cd ../``

      #. ``sudo cp -rf linux-xlnx /opt/Xilinx/git``


   #. Download ``u-boot-xlnx``

      #. ``cd ~/Downloads/``

      #. ``git clone https://github.com/Xilinx/u-boot-xlnx.git``

      #. ``cd u-boot-xlnx/``

      #. ``git checkout -b xilinx-v2021.1``

      #. ``cd ../``

      #. ``sudo cp -rf u-boot-xlnx /opt/Xilinx/git``

   #. ``sudo chown -R <user>:users /opt/Xilinx/git``

      - Example: ``sudo chown -R smith:users /opt/Xilinx/git``

      - Note: This may require adjusting the permissions for ``/opt/Xilinx/git`` or its subdirectories