#!/bin/bash

# ASSUMES FRAMEWORK and xilinx21_1_aarch64 ARE BUILT, at least "--minimal"

start=`date +%s`
echo " Build HDL primitives libraries of 'main' projects"
ocpidev -d $OCPI_CDK_DIR/../projects/core build hdl primitives --hdl-target zynq_ultra
ocpidev -d $OCPI_CDK_DIR/../projects/platform build hdl primitives --hdl-target zynq_ultra
ocpidev -d $OCPI_CDK_DIR/../projects/assets build hdl primitives --hdl-target zynq_ultra
ocpidev -d $OCPI_CDK_DIR/../projects/assets_ts build hdl primitives --hdl-target zynq_ultra
end=`date +%s`
runtime=$((end-start))
echo "Build complete for hdlprimitives:" $runtime
#exit

start=`date +%s`
echo " Build HDL workers libraries of 'main' projects"
# WHEN POSSIBLE, BUILD IN PARALLEL (make -j #)
ocpidev -d $OCPI_CDK_DIR/../projects/core/components build --hdl-target zynq_ultra & sleep 5
ocpidev -d $OCPI_CDK_DIR/../projects/core/hdl/adapters build --hdl-target zynq_ultra & sleep 5
ocpidev -d $OCPI_CDK_DIR/../projects/core/hdl/devices build --hdl-target zynq_ultra & sleep 5
ocpidev -d $OCPI_CDK_DIR/../projects/platform build --hdl-target zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/components/base_comps -j 5 HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/components/comms_comps HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/components/dsp_comps -j 10 HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/components/misc_comps -j 5 HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/components/util_comps -j 5 HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/hdl/adapters HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets/hdl/cards -j 5 HdlTargets=zynq_ultra & sleep 5
ocpidev -d $OCPI_CDK_DIR/../projects/assets/hdl/devices build --hdl-target zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets_ts/components -j 5 HdlTargets=zynq_ultra & sleep 5
make -C $OCPI_CDK_DIR/../projects/assets_ts/hdl/devices -j 5 HdlTargets=zynq_ultra & sleep 5
end=`date +%s`
runtime=$((end-start))
echo "Build complete for workers:" $runtime
#exit

start=`date +%s`
echo " Build 'catch all' from top 'main' projects"
echo " Build 'catch all' project: core"
ocpidev -d $OCPI_CDK_DIR/../projects/core build --hdl-target zynq_ultra
echo " Build 'catch all' project: platform"
ocpidev -d $OCPI_CDK_DIR/../projects/platform build --hdl-target zynq_ultra
echo " Build 'catch all' project: assets"
ocpidev -d $OCPI_CDK_DIR/../projects/assets build --hdl-target zynq_ultra
echo " Build 'catch all' project: assets_ts"
ocpidev -d $OCPI_CDK_DIR/../projects/assets_ts build --hdl-target zynq_ultra
end=`date +%s`
runtime=$((end-start))
echo "Build complete for workers:" $runtime
#exit

start=`date +%s`
echo " Build 'catch all' from top 'main' projects"
echo " Build 'catch all' project: core"
ocpidev -d $OCPI_CDK_DIR/../projects/core build --hdl-target zynq_ultra
echo " Build 'catch all' project: platform"
ocpidev -d $OCPI_CDK_DIR/../projects/platform build --hdl-target zynq_ultra
echo " Build 'catch all' project: assets"
ocpidev -d $OCPI_CDK_DIR/../projects/assets build --hdl-target zynq_ultra
echo " Build 'catch all' project: assets_ts"
ocpidev -d $OCPI_CDK_DIR/../projects/assets_ts build --hdl-target zynq_ultra
end=`date +%s`
runtime=$((end-start))
echo "Build complete for workers:" $runtime
#exit
