#!/bin/bash

# Run's the Component Unit Tests

ocpidev -d $OCPI_CDK_DIR/../projects/core/components run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/comms_comps run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/dsp_comps run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/misc_comps run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets/components/util_comps run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
ocpidev -d $OCPI_CDK_DIR/../projects/assets_ts/components run --mode prep_run --only-platform zrf8_48dr --accumulate-errors
