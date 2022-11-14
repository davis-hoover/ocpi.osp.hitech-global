#####################################################################
Notes to enable and build an RCC platform for ``xilinx21_1_aarch64``
#####################################################################

The "Fixes" listed in this document serve as a log for quick-fixes that I ran in order to attempt to get a working xilinx21_1_aarch64 RCC platform off the ground and may very well be wrong.

Vivado Version: 2021.1

Petalinux Version: 2021.1

OpenCPI Framework Version: 2.4.3

Operating System: Centos7

Preliminary Setup
-----------------

#. Install the framework for release-2.4.3

   ``cd /home/user``

   ``git clone https://gitlab.com/opencpi/opencpi.git``

   ``cd opencpi``

   ``git checkout tags/v2.4.3``

   ``./scripts/install-opencpi.sh --minimal``

#. Setup OpenCPI Enviornment

   ``export OCPI_XILINX_VIVADO_VERSION=2021.1``

   ``source cdk/opencpi-setup.sh -s``

#. Install the zcu104 HDL Platform -> Ensures that all of the HDL assets are built

   ``ocpiadmin install platform zcu104 --minimal``

#. Setup the ZynqReleases directory

   #. Go to the `Xilinx Page <https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1884029195/2021.1+Release>`_

   #. Navigate/scroll to the Downloads section and download the ``2021.1-zcu104-release.tar.xz`` file

   #. ``sudo mkdir -p /opt/Xilinx/ZynqReleases/2021.1/``

   #. ``cd /home/user/Downloads``

   #. ``sudo cp 2021.1-zcu104-release.tar.xz /opt/Xilinx/ZynqReleases/2021.1/``

   #. ``sudo chown -R <user>:users /opt/Xilinx/ZynqReleases``

      - Example: ``sudo chown -R smith:users /opt/Xilinx/ZynqReleases``

      - Note: This may require adjusting the permissions for ``/opt/Xilinx/ZynqReleases`` or its subdirectories

#. Setup ``Xilinx/git/``

   #. ``sudo mkdir -p /opt/Xilinx/git``

   #. Download ``linux-xlnx``

      #. ``cd ~/Downloads``

      #. ``git clone https://github.com/Xilinx/linux-xlnx.git``

      #. ``sudo cp -rf linux-xlnx /opt/Xilinx/git``


   #. Download ``u-boot-xlnx``

      #. ``cd ~/Downloads``

      #. ``git clone https://github.com/Xilinx/u-boot-xlnx.git``

      #. ``sudo cp -rf u-boot-xlnx /opt/Xilinx/git``

  #. ``sudo chown -R <user>:users /opt/Xilinx/git``

     - Example: ``sudo chown -R smith:users /opt/Xilinx/git``

     - Note: This may require adjusting the permissions for ``/opt/Xilinx/git`` or its subdirectories

#. Create a  new RCC Platform: ``xilinx21_1_aarch64``

   #. ``cd opencpi/projects/core/rcc/platforms/``

   #. ``cp -rf xilinx19_2_aarch64 ./xilinx21_1_aarch64``

   #. ``cd xilinx21_1_aarch64``

   #. ``mv xilinx19_2_aarch64.exports ./xilinx21_1_aarch64.exports``

   #. ``mv xilinx19_2_aarch64.mk ./xilinx21_1_aarch64.mk``

   #. Edit the contents of ``xilinx21_1_aarch64.mk``:::

      OcpiXilinxLinuxRepoTag:=xilinx-v2021.1

      include $(OCPI_CDK_DIR)/include/xilinx/xilinx-rcc-platform-definition.mk
      OcpiCXXFlags+=-fno-builtin-memset -fno-builtin-memcpy -Wtype-limits
      OcpiCFlags+=-fno-builtin-memset -fno-builtin-memcpy -Wtype-limits
      OcpiPlatformOs:=linux
      OcpiPlatformOsVersion:=21_1
      OcpiPlatformArch:=aarch64

   ..

   Unregister and re-register project

   #. ``cd opencpi/projects/core``

   #. ``ocpidev unregister project``

   #. ``ocpidev register project``

   Verify that the ``xilinx21_1_aarch64`` project has been registered

   #. ``cd opencpi/``

   #. ``ocpidev show platforms``

xilinx21_1_aarch64 RCC Installation Errors/Fixes
------------------------------------------------

This section highlights the errors that are encountered as they happen, and provides a quick-fix solution to overcome them.

#. Attempt to install ``xilinx21_1_aarch64``

   ``ocpiadmin install platform xilinx21_1_aarch64``

#. Error 1::

   Extracting uramdisk from image.ub
   dumpimage: invalid option -- 'i'
   Usage: dumpimage -l image
             -l ==> list image header information
          dumpimage [-T type] [-p position] [-o outfile] image
             -T ==> declare image type as 'type'
             -p ==> 'position' (starting at 0) of the component to extract from image
             -o ==> extract component to file 'outfile'
          dumpimage -h ==> print usage information and exit
          dumpimage -V ==> print version information and exit
   gzip: /tmp/tmp.uwJLPGkm4c/rootfs.cpio.gz: No such file or directory
   make: *** [gen/release-artifacts.done] Error 1
   make: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64'

..

#. Fix: Comment out the following path::

   $ git diff runtime/hdl-support/xilinx/importXilinxRelease.sh
   diff --git a/runtime/hdl-support/xilinx/importXilinxRelease.sh b/runtime/hdl-support/xilinx/importXilinxRelease.sh
   index d7da9be..2e9a4bf 100755
   --- a/runtime/hdl-support/xilinx/importXilinxRelease.sh
   +++ b/runtime/hdl-support/xilinx/importXilinxRelease.sh
   @@ -91,7 +91,7 @@ done
    # Prepend "local_repo" directories to avoid problems with
    # locally-installed commands that would otherwise conflict.
    #
   -PATH=$local_repo/u-boot-xlnx/tools:$local_repo/linux-xlnx/scripts/dtc:$PATH
   +#PATH=$local_repo/u-boot-xlnx/tools:$local_repo/linux-xlnx/scripts/dtc:$PATH
    echo PATH is: $PATH
    for d in $dir/*; do
        plat=$(basename $d)

..

#. Attempt to re-install ``xilinx21_1_aarch64``

   ``ocpiadmin install platform xilinx21_1_aarch64``

#. Error 2::

   /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/../x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-ar.real: `u' modifier ignored since `D' is the default (see `U')
     CXX      os/linux/src/__ocpi_build_dir__libocpi_os_s_la-OsEther.lo
     CXX      os/linux/src/__ocpi_build_dir__libocpi_os_s_la-OsLoadableModule.lo
   ../gen/os/linux/src/OsEther.cc:30:10: fatal error: sys/sysctl.h: No such file or directory
      30 | #include <sys/sysctl.h>
         |          ^~~~~~~~~~~~~~
   compilation terminated.
   make[4]: *** [os/linux/src/__ocpi_build_dir__libocpi_os_s_la-OsEther.lo] Error 1
   make[4]: *** Waiting for unfinished jobs....
   make[4]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/build/autotools/target-xilinx21_1_aarch64'
   make[3]: *** [all] Error 2
   make[3]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/build/autotools/target-xilinx21_1_aarch64'
   make[2]: *** [build] Error 2
   make[2]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/build/autotools/target-xilinx21_1_aarch64'
   make[1]: *** [build_xilinx21_1_aarch64] Error 2
   make[1]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/build/autotools'
   make: *** [all] Error 2

..

#. Fix: Move the ``#include <sys/sysctl.h>`` library::

   $ git diff os/linux/src/OsEther.cc
   diff --git a/os/linux/src/OsEther.cc b/os/linux/src/OsEther.cc
   index 7a46299..db3b102 100644
   --- a/os/linux/src/OsEther.cc
   +++ b/os/linux/src/OsEther.cc
   @@ -27,13 +27,13 @@
    #include <netdb.h>
    #include <sys/ioctl.h>
    #include <sys/socket.h>
   -#include <sys/sysctl.h>
    #include <stdio.h>
    #include <unistd.h>
    #include <algorithm>
    #include <vector>
    #include "ocpi-config.h"
    #ifdef OCPI_OS_macos
   +#include <sys/sysctl.h>
    #include <arpa/inet.h>
    #include <net/ethernet.h>
    #include <net/if.h>

..

#. Attempt to re-install ``xilinx21_1_aarch64``

   ``ocpiadmin install platform xilinx21_1_aarch64``


#. Error 3::

   make[2]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers'
   Building kernel module target-xilinx21_1_aarch64/opencpi-5.10.0-xilinx-v2021.1-v2021.1.ko
   make[2]: Entering directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers'
   Building/cleaning driver in a CDK environment for platform: xilinx21_1_aarch64
   Xilinx RCC platform is: xilinx21_1_aarch64. Version is: 21_1. Architecture is: aarch64
     CC [M]  /home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/os/linux/driver/opencpi.o - due to target missing
   Building/cleaning driver in a CDK environment for platform: xilinx21_1_aarch64
   Xilinx RCC platform is: xilinx21_1_aarch64. Version is: 21_1. Architecture is: aarch64
     MODPOST /home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/os/linux/driver/Module.symvers - due to target missing
   /bin/bash: scripts/mod/modpost: No such file or directory
   make[4]: *** [/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/os/linux/driver/Module.symvers] Error 1
   make[3]: *** [modules] Error 2
   make[2]: *** [__sub-make] Error 2
   make[2]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers'
   make[1]: *** [target-xilinx21_1_aarch64/opencpi-5.10.0-xilinx-v2021.1-v2021.1.ko] Error 2
   make[1]: Leaving directory `/home/jpalmer/projects/opencpi/releases/rcc-doc-test/opencpi/os/linux/driver'
   make: *** [driver] Error 2

..

#. Fix: There is an error with the modpost script not existing in the kernel headers when the OpenCPI build tooling goes to build the data plane driver.

   ``cd projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers``

   ``make prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

   ``make modules_prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

   ``make scripts V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Doesn't Produce Error

#. Attempt to re-install ``xilinx21_1_aarch64``

   ``ocpiadmin install platform xilinx21_1_aarch64``

Platform Installation
---------------------

This section describes the installation of the zcu102 platform that was used for this guide

#. Install the ``zcu102``

   ``cd opencpi/projects/osps``

   ``git clone -b release-2.4.3 https://gitlab.com/opencpi/osp/ocpi.osp.xilinx.git``

   ``cd ocpi.osp.xilinx/hdl``

   ``rm -rf assemblies``

   ``cd opencpi/projects/osps/ocpi.osp.xilinx``

   ``ocpidev register project``

   ``cd opencpi/``

   ``ocpiadmin install platform zcu102 --minimal``

Boot Artifacts
--------------

**Accompanyed with this Guide are what we consider to be the corrent boot artifacts.**

**This entire section can be skipped if desired. This section outlines that the current Xilinx Wiki / Prebuild images that OpenCPI leverages in the ZynqReleases can no longer be used as intended due to the missing rootfs.tar.xz that is required for Petalinux BSPs after 2019.2**

Xilinx Wiki / Linux Prebuild images for 2021.1 Release
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This section attempts to follow the current OpenCPI boot artifact ``ZynqReleases`` paradigm. However, this paradigm is **no longer valid** due to the absence of the ``rootfs.tar.gz`` that the Xilinx Wiki does not provide. Without this artifact the board cannot properly boot. This method is shown below for completeness as it was initially attempted.

The `Xilinx Wiki / Linux Prebuild Images for 2021.1 Release <https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1884029195/2021.1+Release>`_ Insturcts the user to use the prebuilt release images. These images all use an initramfs based root filesystem. Therefore, only a single FAT32 boot partition is needed on the SD card. To prepare the card for use, copy the ``BOOT.BIN``, ``image.ub``, and ``boot.src`` onto a FAT32 SD card partition.

#. Follow the ``SD-Card Creation -> Single Partition`` section at the bottom of this document to create a FAT32 single partition SD card.

#. Download the ``2021.1-zcu102-release.tar.xz`` (md5sum 000d10a0f93d715bc4b915b4af793a26)

#. ``cd ~/Downloads``

#. ``cp 2021.1-zcu102-release.tar.xz /opt/Xilinx/ZynqReleases/2021.1``

#. Rebuild the RCC platform ``xilinx21_1_aarch64`` to include newly implemented ZynqRelease ``2021.1-zcu102-release`` artifacts during ``ocpiadmin deploy``.

   #. ``cd opencpi/``

   #. ``source cdk/opencpi-setup.sh -s``

   #. ``cd projects/core/rcc/platforms/xilinx21_1_aarch64``

   #. ``rm -rf lib/ gen/``

   #. ``cd opencpi/projects/core``

   #. ``ocpidev unregister project``

   #. ``ocpidev register project``

   #. ``cd opencpi/``

   #. ``ocpiadmin install platform xilinx21_1_aarch64``

   #. Fix: There is an error with the modpost script not existing in the kernel headers when the OpenCPI build tooling goes to build the data plane driver.

      ``cd projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers``

      ``make prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

      ``make modules_prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

      ``make scripts V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Doesn't Produce Error

   #. ``ocpiadmin install platform xilinx21_1_aarch64``

#. Deploy the newly create artifacts

   ``ocpiadmin deploy platform xilinx21_1_aarch64 zcu102``

#. Copy the boot artifacts onto the SD Card

   ``cd opencpi/cdk/zcu102/sdcard-xililinx21_1_aarch64/``

   ``cp BOOT.BIN boot.src image.ub /run/media/<user>/BOOT/``

   ``cp -RLp opencpi /run/media/<user>/BOOT/``

#. Install the SD-Card onto the zcu102

#. Boot

#. Error::

   ERROR: There's no '/dev' on rootfs.

..

Due to this error a dual-partition method, as described in the ``Petalinux Tools Documentation Reference Guide (UG1144)`` was used.

Petalinux artifact Build flow
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Accompanying this guide we will provide the Boot Artifacts that we generated along with the *.xsa file that is leveraged during petalinux. This will allow the user to skip this section and move on to the xilinx21_1_aarch64 RCC Platform specific issues**

The `Petalinux Tools Documentation Reference Guide (UG1144) <https://gitlab.com/opencpi/opencpi/-/compare/develop...2602-update-xilinx-rcc-platforms>`_ section ``Steps to Flash and Boot the Petalinux Images Manually`` instructs the user to copy the ``BOOT.BIN``, ``image.ub``, and ``boot.src`` into the first partition which is  confgirued for FAT32. Then to extract the ``rootfs.tar.gz`` into the second partition which is configured for ext4.

#. Follow the ``SD-Card Creation -> Dual Partition`` section at the bottom of this document to create a FAT32 single partition SD card.

# Create the PS Block Design for the Data-Plane

   Follow the `zcu102 Developers Guide <https://gitlab.com/opencpi/osp/ocpi.osp.xilinx/-/blob/develop/guide/zcu102/Guide.md`_ specifically the ``Configure PS for OpenCPI HDL Control Plane`` followed by the ``Configure PS for OpenCPI Data Plane`` to create a valid ``*.xsa``

#. Create a Petalinux project to leverage the PS Block Design ``*.xsa`` file

   #. Source Petalinux 2021.1

      ``source /opt/Xilinx/Petalinux/2021.1/settings.sh``

   #. Create a petalinux project directory for Control-Plane (cp) 

      ``cd /home/user``

      ``petalinux-create -t project --template zynqMP --name "2021.1_plx_zcu102_dp"``

   #. Import the Hardware Configuration that was exported from the Vivado project. This is the ``*.xsa`` file that was created during the  File → Export → Export Hardware step.

      ``cd 2021.1_plx_zcu102_dp``

      ``petalinux-config --get-hw-description=<*.xsa directory location>``

   #. Once the ``/misc/config`` System Configuration GUI is present in the terminal, continue with the following edits

      #. ``Yocto Settings`` -> ``[*] Enable Buildtools Extended``

      #. Exit -> Yes

      #. If you are presented with: ``ERROR: Failed to generate meta-plnx-generated layer``, this can be fixed with the following command:

         ``sudo sysctl -n -w fs.inotify.max_user_watches=524288``

   #. Build the project **You may need to run ``petalinux-build`` twice to get passed some erroneous errors**

      ``petalinux-build``

   #. Package the ``BOOT.BIN`` image

      ``cd images/linux``

      ``petalinux-package --boot --fsbl --u-boot --force``

      There should now be a ``BOOT.BIN`` in the ``images/linux`` directory

#. Create a ``ZynqReleases`` tar file that's leveraged during the ``ocpiadmin deploy`` stage

   #. Create ``2021.1-zcu102-release`` directory to store boot artifacts

      ``cd /home/user/2021.1_plx_zcu102_dp/images/linux``

      ``mkdir 2021.1-zcu102-release``

   #. Copy the boot artifacts into the directory and create a ``ZynqReleases`` tar

      ``cp BOOT.BIN image.ub boot.scr rootfs.tar.gz 2021.1-zcu102-release``

      ``tar cvfz 2021.1-zcu102-release.tar.xz 2021.1-zcu102-release``

      ``sudo cp 2021.1-zcu102-release.tar.xz /opt/Xilinx/ZynqReleases/2021.1``

      ``sudo chown -R <user>:users /opt/Xilinx/ZynqReleases/2021.1``

          - Example: ``sudo chown -R smith:users /opt/Xilinx/ZynqReleases``

          - Note: This may require adjusting the permissions for ``/opt/Xilinx/ZynqReleases`` or its subdirectories

#. Rebuild the RCC platform ``xilinx21_1_aarch64`` to include newly implemented ZynqRelease ``2021.1-zcu102-release`` artifacts during ``ocpiadmin deploy``.

   #. ``cd opencpi/``

   #. ``source cdk/opencpi-setup.sh -s``

   #. ``cd projects/core/rcc/platforms/xilinx21_1_aarch64``

   #. ``rm -rf lib/ gen/``

   #. ``cd opencpi/projects/core``

   #. ``ocpidev unregister project``

   #. ``ocpidev register project``

   #. ``cd opencpi/``

   #. ``ocpiadmin install platform xilinx21_1_aarch64``

   #. Fix: There is an error with the modpost script not existing in the kernel headers when the OpenCPI build tooling goes to build the data plane driver.

      ``cd projects/core/rcc/platforms/xilinx21_1_aarch64/lib/kernel-headers``

      ``make prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

      ``make modules_prepare V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Produces Error

      ``make scripts V=2 ARCH=arm64 CROSS_COMPILE=/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-`` -> Doesn't Produce Error

   #. ``cd opencpi/``

   #. ``ocpiadmin install platform xilinx21_1_aarch64``

#. Deploy the newly create artifacts

   ``ocpiadmin deploy platform xilinx21_1_aarch64 zcu102``

#. Copy the boot artifacts onto the SD Card

   ``cd opencpi/cdk/zcu102/sdcard-xililinx21_1_aarch64/``

   ``cp BOOT.BIN boot.src image.ub /run/media/<user>/BOOT/``

   ``sudo tar xvf rootfs.tar.gz -C /run/media/<user>/RootFs/``

   ``sudo cp -RLp opencpi/ /run/media/<user>/root/home/RootFs/home/root/``

#. Install the SD-Card onto the zcu102

#. Boot

#. Standalone mode

   #. ``export OCPI_LOCAL_DIR=/home/root/opencpi``

   #. ``cd opencpi/``

   #. ``cp default_mysetup.sh ./mysetup.sh``

   #. ``source /home/root/opencpi/mysetup.sh``

   #. Error::

      root@2021:~/opencpi# source /home/root/opencpi/mysetup.sh
      Attempting to set time from time.nist.gov
      rdate: bad address 'time.nist.gov'
      ====YOU HAVE NO NETWORK CONNECTION and NO HARDWARE CLOCK====
      Set the time using the "date YYYY.MM.DD-HH:MM[:SS]" command.
      Running login script.
      OCPI_CDK_DIR is now /home/root/opencpi
      OCPI_ROOT_DIR is now /home/root/opencpi/..
      Executing /etc/profile.d/opencpi-persist.sh.
      No reserved DMA memory found on the linux boot command line.
      [  172.093402] opencpi: version magic '5.10.0 SMP mod_unload aarch64' should be '5.10.0-xilinx-v2021.1 SMP mod_unload aarch64'
      [  172.106474] opencpi: version magic '5.10.0 SMP mod_unload aarch64' should be '5.10.0-xilinx-v2021.1 SMP mod_unload aarch64'
      insmod: can't insert '/home/root/opencpi/xilinx21_1_aarch64/lib/opencpi-5.10.0-xilinx-v2021.1-v2021.1.ko': invalid module format
      Driver loading failed.

   ..

   #. You can avoid loading the driver by editing the ``zynq_setup.sh``::

      #ocpidriver load

   ..

   #. ``source /home/root/opencpi/mysetup.sh``

   #. Error::

      root@2021:~/opencpi# source /home/root/opencpi/mysetup.sh
      Loading bitstream
      ocpihdl: error while loading shared libraries: libstdc++.so.6: cannot open shared object file: No such file or directory
      Bitstream load error

   ..

Fixing the libstdc++.so.6
-------------------------

This is an investigation of the error found in the ``Standalone Mode`` setup above.

Artifacts located in ``opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib`` that **ARE NOT** being created in the ``opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib``::

   $ pwd
   /home/user/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib
   [jpalmer@localhost lib]$ ll
   total 2512
   -rwxr-xr-x. 1 jpalmer domain users  162968 Oct 28 10:03 ld-2.28.so
   lrwxrwxrwx. 1 jpalmer domain users      10 Oct 28 10:03 ld-linux-aarch64.so.1 -> ld-2.28.so
   lrwxrwxrwx. 1 jpalmer domain users      13 Oct 28 10:03 libgcc_s.so -> libgcc_s.so.1
   -rw-r--r--. 1 jpalmer domain users   99096 Oct 28 10:03 libgcc_s.so.1
   -rwxr-xr-x. 1 jpalmer domain users  157272 Oct 28 10:03 libpthread-2.28.so
   lrwxrwxrwx. 1 jpalmer domain users      18 Oct 28 10:03 libpthread.so.0 -> libpthread-2.28.so
   lrwxrwxrwx. 1 jpalmer domain users      19 Oct 28 10:03 libstdc++.so -> libstdc++.so.6.0.25
   lrwxrwxrwx. 1 jpalmer domain users      19 Oct 28 10:03 libstdc++.so.6 -> libstdc++.so.6.0.25
   -rwxr-xr-x. 1 jpalmer domain users 2139992 Oct 28 10:03 libstdc++.so.6.0.25
   -rw-r--r--. 1 jpalmer domain users    2593 Oct 28 10:03 libstdc++.so.6.0.25-gdb.py

The issues that I'm seeing looks to be caused by a difference in the directory structure of Vitis when comparing 2019.2 to 2021.1, for example:

``/opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/``

``/opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/lib/``

**Investigate ``ld-2.28.so``**

   ``md5sum /home/user/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib/ld-2.28.so``

   - 4f39f9cf33b83de5659e59b8d6a56496

   ``md5sum /opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/ld-2.28.so``

   - 4f39f9cf33b83de5659e59b8d6a56496

   ``cp /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/lib/ld-2.28.so /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib/

This difference in the Vitis project tree is more than likely **not** accounted for in the ``OpenCPI`` framework.

**Investigate ``libgcc_s.so.1``**

   ``md5sum /home/user/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib/libgcc_s.so.1``

   - 209c9f5f0d485a9e1f2aeb3b31129

   ``md5sum /opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/libgcc_s.so.1``

   - 209c9f5f0d485a9e1f2aeb3b31129

   ``cp /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/lib/libgcc_s.so.1 /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib/``

**Investigate ``libpthread-2.28.so``**

   ``md5sum /home/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib/libpthread-2.28.so``

   - c678c9d0be4e7b2b1603b00d5d4373c1

   ``md5sum /opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/libpthread-2.28.so``

   - c678c9d0be4e7b2b1603b00d5d4373c1

   ``cp /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/lib/libpthread-2.32.so /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib/``

**Investigate ``libstdc++.so.6.0.25``**

   ``md5sum /home/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib/libstdc++.so.6.0.25``

   - 28177b6d988ed9b95e8b57974123f766

   ``md5sum /opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/libstdc++.so.6.0.25``

   - 28177b6d988ed9b95e8b57974123f766

   ``cp /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/usr/lib/libstdc++.so.6.0.28 /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib/``

**Investigate ``libstdc++.so.6.0.25-gdb.py``**

   ``md5sum /home/projects/opencpi/projects/core/rcc/platforms/xilinx19_2_aarch64/gen/sdk-artifacts/lib/libstdc++.so.6.0.25-gdb.py``

   - 50819b73b3ad1eb8e6113709627ee1a1

   ``md5sum /opt/Xilinx/Vitis/2019.2/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib/libstdc++.so.6.0.25-gdb.py``

   - 50819b73b3ad1eb8e6113709627ee1a1

   ``cp /opt/Xilinx/Vitis/2021.1/gnu/aarch64/lin/aarch64-linux/aarch64-xilinx-linux/usr/lib/libstdc++.so.6.0.28-gdb.py /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib/``

**Create Symbolic links**

   ``cd /home/user/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib``

   ``ln -s ld-2.32.so ld-linux-aarch64.so.1``

   ``ln -s libpthread-2.32.so libpthread.so.0``

   ``ln -s libstdc++.so.6.0.28 libstdc++.so.6``

   ``ln -s libstdc++.so.6.0.28 libstdc++.so``

   ``sudo chmod 644 libgcc_s.so.1``

   ``ln -s libgcc_s.so.1 libgcc_s.so``

**New Identical 2021.1 directory**::

   $ pwd
   /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/lib
   [jpalmer@localhost lib]$ ll
   total 2156
   -rwxr-xr-x. 1 jpalmer domain users  149376 Oct 28 11:49 ld-2.32.so
   lrwxrwxrwx. 1 jpalmer domain users      10 Oct 28 12:20 ld-linux-aarch64.so.1 -> ld-2.32.so
   lrwxrwxrwx. 1 jpalmer domain users      13 Oct 28 12:27 libgcc_s.so -> libgcc_s.so.1
   -rw-r--r--. 1 jpalmer domain users   83792 Oct 28 12:06 libgcc_s.so.1
   -rwxr-xr-x. 1 jpalmer domain users  113184 Oct 28 12:05 libpthread-2.32.so
   lrwxrwxrwx. 1 jpalmer domain users      18 Oct 28 12:21 libpthread.so.0 -> libpthread-2.32.so
   lrwxrwxrwx. 1 jpalmer domain users      19 Oct 28 12:28 libstdc++.so -> libstdc++.so.6.0.28
   lrwxrwxrwx. 1 jpalmer domain users      19 Oct 28 12:21 libstdc++.so.6 -> libstdc++.so.6.0.28
   -rwxr-xr-x. 1 jpalmer domain users 1849832 Oct 28 12:13 libstdc++.so.6.0.28
   -rw-r--r--. 1 jpalmer domain users    2377 Oct 28 12:19 libstdc++.so.6.0.28-gdb.py

**Copy the newly created artifacts to the same place that they exist on for xilinx19_2_aarch64**

``cd /home/opencpi/projects/core/rcc/platforms/xilinx21_1_aarch64/gen/sdk-artifacts/``

``cp -RLp lib/* /home/user/opencpi/cdk/zcu102/sdcard-xilinx21_1_aarch64/opencpi/xilinx19_2_aarch64/sdk/lib/``

#. Re-Copy the boot artifacts onto the SD Card

   ``cd opencpi/cdk/zcu102/sdcard-xililinx21_1_aarch64/``

   ``cp BOOT.BIN boot.src image.ub /run/media/<user>/BOOT/``

   ``sudo tar xvf rootfs.tar.gz -C /run/media/<user>/RootFs/``

   ``sudo cp -RLp opencpi/ /run/media/<user>/root/home/RootFs/home/root/``

#. Install the SD-Card onto the zcu102

#. Boot

#. Standalone mode

   #. ``export OCPI_LOCAL_DIR=/home/root/opencpi``

   #. ``cd opencpi/``

   #. ``cp default_mysetup.sh ./mysetup.sh``

   #. ``source /home/root/opencpi/mysetup.sh``

   #. Error::

      root@2021:~/opencpi# source /home/root/opencpi/mysetup.sh
      Attempting to set time from time.nist.gov
      rdate: bad address 'time.nist.gov'
      ====YOU HAVE NO NETWORK CONNECTION and NO HARDWARE CLOCK====
      Set the time using the "date YYYY.MM.DD-HH:MM[:SS]" command.
      Running login script.
      OCPI_CDK_DIR is now /home/root/opencpi
      OCPI_ROOT_DIR is now /home/root/opencpi/..
      Executing /etc/profile.d/opencpi-persist.sh.
      No reserved DMA memory found on the linux boot command line.
      [  172.093402] opencpi: version magic '5.10.0 SMP mod_unload aarch64' should be '5.10.0-xilinx-v2021.1 SMP mod_unload aarch64'
      [  172.106474] opencpi: version magic '5.10.0 SMP mod_unload aarch64' should be '5.10.0-xilinx-v2021.1 SMP mod_unload aarch64'
      insmod: can't insert '/home/root/opencpi/xilinx21_1_aarch64/lib/opencpi-5.10.0-xilinx-v2021.1-v2021.1.ko': invalid module format
      Driver loading failed.

   ..

   #. You can avoid loading the driver by editing the ``zynq_setup.sh``::

      #ocpidriver load

   ..

   #. ``source /home/root/opencpi/mysetup.sh``

   #. Error::

      root@2021:~/opencpi# source /home/root/opencpi/mysetup.sh
      Loading bitstream
      Exiting for problem: error loading device pl:0: Can't open /dev/ocpi/mem for bitstream loading: No such file or directory(2)
      Bitstream load error

   #. Fix:


      #. ``cd /dev``

      #. ``touch ocpi=mem``

      #. ``mkdir ocpi``

      #. ``cd ocpi``

      #. ``ln -s ../ocpi=mem mem``

      #. ``cd /home/root/opencpi``

   #. ``source /home/root/opencpi/mysetup.sh``

   Error::

      Loading bitstream
      Exiting for problem: error loading device pl:0: Error loading fpga: Inappropriate ioctl for device(25)
      Bitstream load error

   ..

   fpga_manager inspection of xilinx21_1_aarch64::

     % find . -iname "fpga_manager"
      ./sys/class/fpga_manager
      ./sys/devices/platform/firmware:zynqmp-firmware/firmware:zynqmp-firmware:pcap/fpga_manager

   ..

   fpga_manager inspection of xilinx19_2_aarch64::

     % find . -iname "fpga_manager"
      ./sys/class/fpga_manager
      ./sys/devices/platform/pcap/fpga_manager

   ..

   **Currently stuck on this error**

SD-Card Creation
----------------

Single Partition
^^^^^^^^^^^^^^^^

#. Install the microSD card

#. Be sure to save off any important information on the microSD card

#. ``sudo umount /dev/sda1`` and/or ``sudo umount /dev/sda2``

#. ``sudo fdisk /dev/sda``

#. List the current partition table

   Command (m for help): ``p``

#. Remove all current partitions

   Command (m for help): ``d``

#. Make the following selections to create one partition

   New ``n``, Primary ``p``, Partition number ``1``, First sector [enter] (default), Last sector [enter] (default)

#. Format partition

   Type ``t``, FAT32 ``b``

#. Write table to disk and exit

   Command (m for help): ``w``

#. Uninstall and reinstall the microSD card / USB drive

#. ``sudo umount /dev/sda1`` and/or ``sudo umount /dev/sda2``

#. ``sudo mkfs.vfat -n BOOT /dev/sda1``::

   mkfs.fat 3.0.20 (12 Jun 2013)

..

#. Uninstall and reinstall the microSD card / USB drive

#. Check that the partition ``BOOT`` has been created

Dual Partition
^^^^^^^^^^^^^^

#. Install the microSD card

#. Be sure to save off any important information on the microSD card

#. ``sudo umount /dev/sda1`` and/or ``sudo umount /dev/sda2``

#. ``sudo fdisk /dev/sda``

#. List the current partition table

   Command (m for help): ``p``

#. Remove all current partitions

   Command (m for help): ``d``

#. Make the following selections to create the FAT32 partition

   New ``n``, Primary ``p``, Partition number ``1``, First sector [enter] (default), Last sector ``21111220``

#. Format partition

   Type ``t``, FAT32 ``b``

#. Make the following selections to create the ext4 partition

   New ``n``, Primary ``p``, Partition number ``2``, First sector [enter] (default), Last sector [enter] (default)

#. Format partition

   Type ``t``, Partition number ``2``, extended ``5``

#. Write table to disk and exit

   Command (m for help): ``w``

#. Uninstall and reinstall the microSD card / USB drive

#. ``sudo umount /dev/sda1`` and/or ``sudo umount /dev/sda2``

#. ``sudo mkfs.vfat -n BOOT /dev/sda1``::

   mkfs.fat 3.0.20 (12 Jun 2013)

..

#. ``sudo mkfs.ext4 -L RootFs /dev/sda2``::

   mke2fs 1.42.9 (28-Dec-2013)
   Filesystem label=RootFs
   OS type: Linux
   Block size=4096 (log=2)
   Fragment size=4096 (log=2)
   Stride=0 blocks, Stripe width=0 blocks
   318240 inodes, 1272576 blocks
   63628 blocks (5.00%) reserved for the super user
   First data block=0
   Maximum filesystem blocks=1304428544
   39 block groups
   32768 blocks per group, 32768 fragments per group
   8160 inodes per group
   Superblock backups stored on blocks:
           32768, 98304, 163840, 229376, 294912, 819200, 884736

   Allocating group tables: done
   Writing inode tables: done
   Creating journal (32768 blocks): done
   Writing superblocks and filesystem accounting information: done

..

#. Uninstall and reinstall the microSD card / USB drive

#. Check that the partition ``BOOT``, and ``RootFs`` has been created
