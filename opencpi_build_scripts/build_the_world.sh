#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Collect Info
echo Enter desired OpenCPI directory name: #\(Press enter for default\):
read opencpi_name
echo Enter desired OpenCPI branch name:
read ocpi_branch_name
echo Enter desired OSP SHH clone name:
read osp_name
echo Enter desired OSP branch name:
read osp_branch_name

# Clone OpenCPI
dir_name="$opencpi_name"
mkdir=$opencpi_name
#git clone git@gitlab.com:opencpi/opencpi.git $opencpi_name
git clone https://gitlab.com/opencpi/opencpi.git $opencpi_name

# CD to opencpi directory
#if [ -d "$dir_name" ]; then
#  pushd $opencpi_name
#else
#  pushd opencpi
#fi

# Show branchs ask user to choose
cd $opencpi_name
git checkout $ocpi_branch_name

## Edit hdl-targets.xml to include FPGA part number
hdl_targets_path=$(find . -name "hdl-targets.xml")
sed -i 's/xczu28dr xczu9eg xczu7ev xczu3cg/xczu28dr xczu9eg xczu7ev xczu3cg xczu48dr/g' $hdl_targets_path

# Clone OSP
pushd projects/osps
git clone -b $osp_branch_name $osp_name
popd

osp_name=$(echo "$osp_name" | sed 's/.*\///')
osp_name=$(echo "$osp_name" | sed 's/.git//g')
echo $osp_name

## Copy fmc_plus.xml from cloned OSP project to core project
fmc_plus_path=$(find . -name "fmc_plus.xml")
cp $fmc_plus_path projects/core/hdl/cards/specs

# Install OpenCPI
./scripts/install-opencpi.sh --minimal

# Source OCPI
source cdk/opencpi-setup.sh -s
export OCPI_XILINX_VIVADO_VERSION=2021.1

# Register OSP
pushd projects/osps/$osp_name
ocpidev register project
popd
pushd $ocpi_branch_name

## Install OSP
ocpiadmin install platform xilinx21_1_aarch64 --minimal
ocpiadmin install platform zrf8_48dr --minimal
