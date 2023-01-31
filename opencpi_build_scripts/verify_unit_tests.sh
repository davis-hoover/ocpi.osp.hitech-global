#!/bin/bash

# Verify the Component Unit Tests

ocpidev -d $OCPI_CDK_DIR/../projects/core/components run --mode verify --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/comms_comps run --mode verify --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/dsp_comps run --mode verify --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/misc_comps run --mode verify --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/util_comps run --mode verify --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets_ts/components run --mode verify --only-platform zrf8_48dr --accumulate-errors

