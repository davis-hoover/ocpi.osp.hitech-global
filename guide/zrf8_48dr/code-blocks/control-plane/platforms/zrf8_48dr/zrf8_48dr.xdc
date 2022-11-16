# OpenCPI additions to the above, which is unmodified from the original

create_clock -name clk_fpga_0 -period 10.000 [get_pins -hier * -filter {NAME =~ /ps/U0/inst/PS8_i/PLCLK[0]}]
set_property DONT_TOUCH true [get_cells "ftop/pfconfig_i/zrf8_48dr_i/worker/ps/U0/inst/PS8_i"]

