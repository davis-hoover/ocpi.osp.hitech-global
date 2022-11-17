#set_property PACKAGE_PIN A6 [get_ports {LED_Out_0[0]}]
#set_property PACKAGE_PIN C6 [get_ports {LED_Out_0[1]}]
#set_property PACKAGE_PIN D6 [get_ports {LED_Out_0[2]}]
#set_property PACKAGE_PIN E6 [get_ports {LED_Out_0[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED_Out_0[?]}]
#
#set_property PACKAGE_PIN AV13 [get_ports SI5341_Clk_Rst_N_0]
#set_property PACKAGE_PIN AV15 [get_ports SI5341_Clk_FDEC_0]
#set_property PACKAGE_PIN AW16 [get_ports SI5341_Clk_FINC_0]
#set_property PACKAGE_PIN AF15 [get_ports SI5341_Clk_Sync_N_0]
#set_property PACKAGE_PIN AV16 [get_ports SI5341_Clk_LOL_N_0]
#set_property PACKAGE_PIN AW15 [get_ports SI5341_Clk_INTR_N_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_Rst_N_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_FDEC_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_FINC_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_Sync_N_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_LOL_N_0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5341_Clk_INTR_N_0]
#
#set_property PACKAGE_PIN F6 [get_ports RF_PLL_CSB]
#set_property PACKAGE_PIN A5 [get_ports RF_PLL_SCK]
#set_property PACKAGE_PIN B5 [get_ports RF_PLL_SDI]
#set_property PACKAGE_PIN C5 [get_ports RF_PLL_MUXout]
#set_property IOSTANDARD LVCMOS33 [get_ports RF_PLL_CSB]
#set_property IOSTANDARD LVCMOS33 [get_ports RF_PLL_SCK]
#set_property IOSTANDARD LVCMOS33 [get_ports RF_PLL_SDI]
#set_property IOSTANDARD LVCMOS33 [get_ports RF_PLL_MUXout]
#
##set_property PACKAGE_PIN E8 [get_ports SI5341_I2C_SDA_0]
##set_property PACKAGE_PIN E9 [get_ports SI5341_I2C_SCL_0]
##set_property PACKAGE_PIN D10 [get_ports SI5341_I2C_RST_N_0]
##set_property IOSTANDARD LVCMOS33 [get_ports SI5341_I2C_SDA_0]
##set_property IOSTANDARD LVCMOS33 [get_ports SI5341_I2C_SCL_0]
##set_property IOSTANDARD LVCMOS33 [get_ports SI5341_I2C_RST_N_0]
#
##User clock
#set_property PACKAGE_PIN C8 [get_ports Clk_Pl_User1_P_0]  
#set_property PACKAGE_PIN C7 [get_ports Clk_Pl_User1_N_0]  
#set_property IOSTANDARD LVPECL [get_ports Clk_Pl_User1_?_0]
#create_clock -period 10.000 -name user_clk1 [get_ports Clk_Pl_User1_P_0]
#
## FMC Signals
#set_property PACKAGE_PIN AV11 [get_ports {En_12v_0[0]}]  ;#LA23_P
#set_property PACKAGE_PIN AN8 [get_ports {En_12v_0[1]}]   ;#LA24_P
#set_property IOSTANDARD LVCMOS18 [get_ports {En_12v_0[?]}]
#
#set_property PACKAGE_PIN AM22 [get_ports {INT_N_0[0]}]  ;#LA08_N
#set_property PACKAGE_PIN AV12 [get_ports {INT_N_0[1]}]  ;#LA19_N
#set_property PACKAGE_PIN AL22 [get_ports {INT_P_0[0]}]  ;#LA08_P
#set_property PACKAGE_PIN AU12 [get_ports {INT_P_0[1]}]  ;#LA19_P
#set_property IOSTANDARD LVDS [get_ports {INT_?_0[?]}]
#set_property DIFF_TERM TRUE [get_ports {INT_?_0[?]}]
#
#set_property PACKAGE_PIN AL20 [get_ports {SHDN_N_0[0]}]  ;#LA07_N
#set_property PACKAGE_PIN AH18 [get_ports {SHDN_N_0[1]}]  ;#LA16_N
#set_property PACKAGE_PIN AL21 [get_ports {SHDN_P_0[0]}]  ;#LA07_P
#set_property PACKAGE_PIN AG18 [get_ports {SHDN_P_0[1]}]  ;#LA16_P
#set_property IOSTANDARD LVDS [get_ports {SHDN_?_0[?]}]
#
#set_property PACKAGE_PIN AT22 [get_ports {FAN_CTRL_N_0[0]}]  ;#LA02_N
#set_property PACKAGE_PIN AH20 [get_ports {FAN_CTRL_N_0[1]}]  ;#LA12_N
#set_property PACKAGE_PIN AR22 [get_ports {FAN_CTRL_P_0[0]}]  ;#LA02_P
#set_property PACKAGE_PIN AG20 [get_ports {FAN_CTRL_P_0[1]}]  ;#LA12_P
#set_property IOSTANDARD LVDS [get_ports {FAN_CTRL_?_0[?]}]
#
#set_property PACKAGE_PIN AV18 [get_ports {ADC_INT_N_0[0]}]  ;#LA06_N
#set_property PACKAGE_PIN AT17 [get_ports {ADC_INT_N_0[1]}]  ;#LA15_N
#set_property PACKAGE_PIN AU18 [get_ports {ADC_INT_P_0[0]}]  ;#LA06_P
#set_property PACKAGE_PIN AR17 [get_ports {ADC_INT_P_0[1]}]  ;#LA15_P
#set_property IOSTANDARD LVDS [get_ports {ADC_INT_?_0[?]}]
#set_property DIFF_TERM TRUE [get_ports {ADC_INT_?_0[?]}]
#
#set_property PACKAGE_PIN AP21 [get_ports {SPI_CLK_N_0[0]}]  ;#CLK0_M2C_N
#set_property PACKAGE_PIN AR18 [get_ports {SPI_CLK_N_0[1]}]  ;#LA00_N_CC
#set_property PACKAGE_PIN AN21 [get_ports {SPI_CLK_P_0[0]}]  ;#CLK0_M2C_P
#set_property PACKAGE_PIN AP18 [get_ports {SPI_CLK_P_0[1]}]  ;#LA00_P_CC
#set_property IOSTANDARD LVDS [get_ports {SPI_CLK_?_0[?]}]
#
#set_property PACKAGE_PIN AK21 [get_ports {SPI_CS1_N_0[0]}]  ;#LA05_N
#set_property PACKAGE_PIN AK18 [get_ports {SPI_CS1_N_0[1]}]  ;#LA14_N
#set_property PACKAGE_PIN AK22 [get_ports {SPI_CS1_P_0[0]}]  ;#LA05_P
#set_property PACKAGE_PIN AJ18 [get_ports {SPI_CS1_P_0[1]}]  ;#LA14_P
#set_property IOSTANDARD LVDS [get_ports {SPI_CS1_?_0[?]}]
#
#set_property PACKAGE_PIN AW21 [get_ports {SPI_CS2_N_0[0]}]  ;#LA04_N
#set_property PACKAGE_PIN AJ19 [get_ports {SPI_CS2_N_0[1]}]  ;#LA13_N
#set_property PACKAGE_PIN AV21 [get_ports {SPI_CS2_P_0[0]}]  ;#LA04_P
#set_property PACKAGE_PIN AJ20 [get_ports {SPI_CS2_P_0[1]}]  ;#LA13_P
#set_property IOSTANDARD LVDS [get_ports {SPI_CS2_?_0[?]}]
#
#set_property PACKAGE_PIN AT21 [get_ports {SPI_CS3_N_0[0]}]  ;#LA03_N
#set_property PACKAGE_PIN AN20 [get_ports {SPI_CS3_N_0[1]}]  ;#LA01_N_CC
#set_property PACKAGE_PIN AR21 [get_ports {SPI_CS3_P_0[0]}]  ;#LA03_P
#set_property PACKAGE_PIN AM20 [get_ports {SPI_CS3_P_0[1]}]  ;#LA01_P_CC
#set_property IOSTANDARD LVDS [get_ports {SPI_CS3_?_0[?]}]
#
#set_property PACKAGE_PIN AV17 [get_ports {SPI_MISO_N_0[0]}]  ;#LA10_N
#set_property PACKAGE_PIN AN13 [get_ports {SPI_MISO_N_0[1]}]  ;#LA21_N
#set_property PACKAGE_PIN AU17 [get_ports {SPI_MISO_P_0[0]}]  ;#LA10_P
#set_property PACKAGE_PIN AM13 [get_ports {SPI_MISO_P_0[1]}]  ;#LA21_P
#set_property IOSTANDARD LVDS [get_ports {SPI_MISO_?_0[?]}]
#set_property DIFF_TERM TRUE [get_ports {SPI_MISO_?_0[?]}]
#
#set_property PACKAGE_PIN AM19 [get_ports {SPI_MOSI_N_0[0]}]  ;#LA11_N
#set_property PACKAGE_PIN AU10 [get_ports {SPI_MOSI_N_0[1]}]  ;#LA22_N
#set_property PACKAGE_PIN AL19 [get_ports {SPI_MOSI_P_0[0]}]  ;#LA11_P
#set_property PACKAGE_PIN AT10 [get_ports {SPI_MOSI_P_0[1]}]  ;#LA22_P
#set_property IOSTANDARD LVDS [get_ports {SPI_MOSI_?_0[?]}]
#
#set_property PACKAGE_PIN AT19 [get_ports {TR_SW_N_0[0]}]  ;#LA09_N
#set_property PACKAGE_PIN AW8  [get_ports {TR_SW_N_0[1]}]  ;#LA20_N
#set_property PACKAGE_PIN AR19 [get_ports {TR_SW_P_0[0]}]  ;#LA09_P
#set_property PACKAGE_PIN AW9  [get_ports {TR_SW_P_0[1]}]  ;#LA20_P
#set_property IOSTANDARD LVDS [get_ports {TR_SW_?_0[?]}]
#
## DDR4 signals  
#
#set_property PACKAGE_PIN B15  [ get_ports "C0_DDR4_0_act_n" ]
#
#set_property PACKAGE_PIN H13  [ get_ports "C0_DDR4_0_ba[0]" ]
#set_property PACKAGE_PIN A14  [ get_ports "C0_DDR4_0_ba[1]" ]
#set_property PACKAGE_PIN B12  [ get_ports "C0_DDR4_0_bg[0]" ]
#set_property PACKAGE_PIN D11  [ get_ports "C0_DDR4_0_bg[1]" ]
#set_property PACKAGE_PIN J10  [ get_ports "C0_DDR4_0_ck_c[0]" ]
#set_property PACKAGE_PIN J11  [ get_ports "C0_DDR4_0_ck_t[0]" ]
#set_property PACKAGE_PIN J13  [ get_ports "C0_DDR4_0_ck_c[1]" ]
#set_property PACKAGE_PIN J14  [ get_ports "C0_DDR4_0_ck_t[1]" ]
#set_property PACKAGE_PIN A12  [ get_ports "C0_DDR4_0_cke[0]" ]
#set_property PACKAGE_PIN A15  [ get_ports "C0_DDR4_0_cke[1]" ]
#set_property PACKAGE_PIN H10  [ get_ports "C0_DDR4_0_cs_n[0]" ]
#set_property PACKAGE_PIN E14  [ get_ports "C0_DDR4_0_cs_n[1]" ]
##set_property PACKAGE_PIN K11  [ get_ports "C0_DDR4_0_cs_n[2]" ]
##set_property PACKAGE_PIN F12  [ get_ports "C0_DDR4_0_cs_n[3]" ]
#set_property PACKAGE_PIN J7  [ get_ports "C0_DDR4_0_odt[0]" ]
#set_property PACKAGE_PIN H11 [ get_ports "C0_DDR4_0_odt[1]" ]
#set_property PACKAGE_PIN D13  [ get_ports "C0_DDR4_0_reset_n" ]
#
#set_property PACKAGE_PIN F11  [ get_ports "C0_DDR4_0_adr[0]" ]
#set_property PACKAGE_PIN C13  [ get_ports "C0_DDR4_0_adr[1]" ]
#set_property PACKAGE_PIN F14  [ get_ports "C0_DDR4_0_adr[2]" ]
#set_property PACKAGE_PIN F10  [ get_ports "C0_DDR4_0_adr[3]" ]
#set_property PACKAGE_PIN E11  [ get_ports "C0_DDR4_0_adr[4]" ]
#set_property PACKAGE_PIN E13  [ get_ports "C0_DDR4_0_adr[5]" ]
#set_property PACKAGE_PIN B13  [ get_ports "C0_DDR4_0_adr[6]" ]
#set_property PACKAGE_PIN E12  [ get_ports "C0_DDR4_0_adr[7]" ]
#set_property PACKAGE_PIN A11  [ get_ports "C0_DDR4_0_adr[8]" ]
#set_property PACKAGE_PIN C12  [ get_ports "C0_DDR4_0_adr[9]" ]
#set_property PACKAGE_PIN K13  [ get_ports "C0_DDR4_0_adr[10]" ]
#set_property PACKAGE_PIN C15  [ get_ports "C0_DDR4_0_adr[11]" ]
#set_property PACKAGE_PIN C11  [ get_ports "C0_DDR4_0_adr[12]" ]
#set_property PACKAGE_PIN K10  [ get_ports "C0_DDR4_0_adr[13]" ]
#set_property PACKAGE_PIN B14  [ get_ports "C0_DDR4_0_adr[14]" ]
#set_property PACKAGE_PIN H12  [ get_ports "C0_DDR4_0_adr[15]" ]
#set_property PACKAGE_PIN K12  [ get_ports "C0_DDR4_0_adr[16]" ]
#
#set_property PACKAGE_PIN N14  [ get_ports "C0_DDR4_0_dm_n[0]" ]
#set_property PACKAGE_PIN J15  [ get_ports "C0_DDR4_0_dm_n[1]" ]
#set_property PACKAGE_PIN G17  [ get_ports "C0_DDR4_0_dm_n[2]" ]
#set_property PACKAGE_PIN D18  [ get_ports "C0_DDR4_0_dm_n[3]" ]
#set_property PACKAGE_PIN J23  [ get_ports "C0_DDR4_0_dm_n[4]" ]
#set_property PACKAGE_PIN F21  [ get_ports "C0_DDR4_0_dm_n[5]" ]
#set_property PACKAGE_PIN C23  [ get_ports "C0_DDR4_0_dm_n[6]" ]
#set_property PACKAGE_PIN N20  [ get_ports "C0_DDR4_0_dm_n[7]" ]
#set_property PACKAGE_PIN J8   [ get_ports "C0_DDR4_0_dm_n[8]" ]
#
#set_property PACKAGE_PIN M12  [ get_ports "C0_DDR4_0_dq[0]" ]
#set_property PACKAGE_PIN M13  [ get_ports "C0_DDR4_0_dq[1]" ]
#set_property PACKAGE_PIN N15  [ get_ports "C0_DDR4_0_dq[2]" ]
#set_property PACKAGE_PIN M17  [ get_ports "C0_DDR4_0_dq[3]" ]
#set_property PACKAGE_PIN L12  [ get_ports "C0_DDR4_0_dq[4]" ]
#set_property PACKAGE_PIN N13  [ get_ports "C0_DDR4_0_dq[5]" ]
#set_property PACKAGE_PIN M15  [ get_ports "C0_DDR4_0_dq[6]" ]
#set_property PACKAGE_PIN N17  [ get_ports "C0_DDR4_0_dq[7]" ]
#set_property PACKAGE_PIN K17  [ get_ports "C0_DDR4_0_dq[8]" ]
#set_property PACKAGE_PIN L17  [ get_ports "C0_DDR4_0_dq[9]" ]
#set_property PACKAGE_PIN J19  [ get_ports "C0_DDR4_0_dq[10]" ]
#set_property PACKAGE_PIN H16  [ get_ports "C0_DDR4_0_dq[11]" ]
#set_property PACKAGE_PIN J16  [ get_ports "C0_DDR4_0_dq[12]" ]
#set_property PACKAGE_PIN K16  [ get_ports "C0_DDR4_0_dq[13]" ]
#set_property PACKAGE_PIN H17  [ get_ports "C0_DDR4_0_dq[14]" ]
#set_property PACKAGE_PIN J18  [ get_ports "C0_DDR4_0_dq[15]" ]
#set_property PACKAGE_PIN E16  [ get_ports "C0_DDR4_0_dq[16]" ]
#set_property PACKAGE_PIN F15  [ get_ports "C0_DDR4_0_dq[17]" ]
#set_property PACKAGE_PIN E17  [ get_ports "C0_DDR4_0_dq[18]" ]
#set_property PACKAGE_PIN H18  [ get_ports "C0_DDR4_0_dq[19]" ]
#set_property PACKAGE_PIN F16  [ get_ports "C0_DDR4_0_dq[20]" ]
#set_property PACKAGE_PIN G15  [ get_ports "C0_DDR4_0_dq[21]" ]
#set_property PACKAGE_PIN E18  [ get_ports "C0_DDR4_0_dq[22]" ]
#set_property PACKAGE_PIN G18  [ get_ports "C0_DDR4_0_dq[23]" ]
#set_property PACKAGE_PIN C16  [ get_ports "C0_DDR4_0_dq[24]" ]
#set_property PACKAGE_PIN D15  [ get_ports "C0_DDR4_0_dq[25]" ]
#set_property PACKAGE_PIN C17  [ get_ports "C0_DDR4_0_dq[26]" ]
#set_property PACKAGE_PIN A19  [ get_ports "C0_DDR4_0_dq[27]" ]
#set_property PACKAGE_PIN A16  [ get_ports "C0_DDR4_0_dq[28]" ]
#set_property PACKAGE_PIN D16  [ get_ports "C0_DDR4_0_dq[29]" ]
#set_property PACKAGE_PIN A17  [ get_ports "C0_DDR4_0_dq[30]" ]
#set_property PACKAGE_PIN B19  [ get_ports "C0_DDR4_0_dq[31]" ]
#set_property PACKAGE_PIN H23  [ get_ports "C0_DDR4_0_dq[32]" ]
#set_property PACKAGE_PIN J21  [ get_ports "C0_DDR4_0_dq[33]" ]
#set_property PACKAGE_PIN H22  [ get_ports "C0_DDR4_0_dq[34]" ]
#set_property PACKAGE_PIN K24  [ get_ports "C0_DDR4_0_dq[35]" ]
#set_property PACKAGE_PIN G23  [ get_ports "C0_DDR4_0_dq[36]" ]
#set_property PACKAGE_PIN H21  [ get_ports "C0_DDR4_0_dq[37]" ]
#set_property PACKAGE_PIN G22  [ get_ports "C0_DDR4_0_dq[38]" ]
#set_property PACKAGE_PIN L24  [ get_ports "C0_DDR4_0_dq[39]" ]
#set_property PACKAGE_PIN E21  [ get_ports "C0_DDR4_0_dq[40]" ]
#set_property PACKAGE_PIN F20  [ get_ports "C0_DDR4_0_dq[41]" ]
#set_property PACKAGE_PIN E23  [ get_ports "C0_DDR4_0_dq[42]" ]
#set_property PACKAGE_PIN F24  [ get_ports "C0_DDR4_0_dq[43]" ]
#set_property PACKAGE_PIN D21  [ get_ports "C0_DDR4_0_dq[44]" ]
#set_property PACKAGE_PIN E22  [ get_ports "C0_DDR4_0_dq[45]" ]
#set_property PACKAGE_PIN E24  [ get_ports "C0_DDR4_0_dq[46]" ]
#set_property PACKAGE_PIN G20  [ get_ports "C0_DDR4_0_dq[47]" ]
#set_property PACKAGE_PIN C20  [ get_ports "C0_DDR4_0_dq[48]" ]
#set_property PACKAGE_PIN A20  [ get_ports "C0_DDR4_0_dq[49]" ]
#set_property PACKAGE_PIN B24  [ get_ports "C0_DDR4_0_dq[50]" ]
#set_property PACKAGE_PIN C21  [ get_ports "C0_DDR4_0_dq[51]" ]
#set_property PACKAGE_PIN B20  [ get_ports "C0_DDR4_0_dq[52]" ]
#set_property PACKAGE_PIN A21  [ get_ports "C0_DDR4_0_dq[53]" ]
#set_property PACKAGE_PIN C22  [ get_ports "C0_DDR4_0_dq[54]" ]
#set_property PACKAGE_PIN A24  [ get_ports "C0_DDR4_0_dq[55]" ]
#set_property PACKAGE_PIN L19  [ get_ports "C0_DDR4_0_dq[56]" ]
#set_property PACKAGE_PIN L21  [ get_ports "C0_DDR4_0_dq[57]" ]
#set_property PACKAGE_PIN L23  [ get_ports "C0_DDR4_0_dq[58]" ]
#set_property PACKAGE_PIN N19  [ get_ports "C0_DDR4_0_dq[59]" ]
#set_property PACKAGE_PIN L20  [ get_ports "C0_DDR4_0_dq[60]" ]
#set_property PACKAGE_PIN M19  [ get_ports "C0_DDR4_0_dq[61]" ]
#set_property PACKAGE_PIN L22  [ get_ports "C0_DDR4_0_dq[62]" ]
#set_property PACKAGE_PIN M20  [ get_ports "C0_DDR4_0_dq[63]" ]
#set_property PACKAGE_PIN F9   [ get_ports "C0_DDR4_0_dq[64]" ]
#set_property PACKAGE_PIN G7   [ get_ports "C0_DDR4_0_dq[65]" ]
#set_property PACKAGE_PIN H6   [ get_ports "C0_DDR4_0_dq[66]" ]
#set_property PACKAGE_PIN G6   [ get_ports "C0_DDR4_0_dq[67]" ]
#set_property PACKAGE_PIN G9   [ get_ports "C0_DDR4_0_dq[68]" ]
#set_property PACKAGE_PIN H7   [ get_ports "C0_DDR4_0_dq[69]" ]
#set_property PACKAGE_PIN K9   [ get_ports "C0_DDR4_0_dq[70]" ]
#set_property PACKAGE_PIN J9   [ get_ports "C0_DDR4_0_dq[71]" ]
#
#set_property PACKAGE_PIN L14  [ get_ports "C0_DDR4_0_dqs_c[0]" ]
#set_property PACKAGE_PIN K18  [ get_ports "C0_DDR4_0_dqs_c[1]" ]
#set_property PACKAGE_PIN F19  [ get_ports "C0_DDR4_0_dqs_c[2]" ]
#set_property PACKAGE_PIN B17  [ get_ports "C0_DDR4_0_dqs_c[3]" ]
#set_property PACKAGE_PIN H20  [ get_ports "C0_DDR4_0_dqs_c[4]" ]
#set_property PACKAGE_PIN D24  [ get_ports "C0_DDR4_0_dqs_c[5]" ]
#set_property PACKAGE_PIN A22  [ get_ports "C0_DDR4_0_dqs_c[6]" ]
#set_property PACKAGE_PIN K22  [ get_ports "C0_DDR4_0_dqs_c[7]" ]
#set_property PACKAGE_PIN G8   [ get_ports "C0_DDR4_0_dqs_c[8]" ]
#set_property PACKAGE_PIN L15  [ get_ports "C0_DDR4_0_dqs_t[0]" ]
#set_property PACKAGE_PIN K19  [ get_ports "C0_DDR4_0_dqs_t[1]" ]
#set_property PACKAGE_PIN G19  [ get_ports "C0_DDR4_0_dqs_t[2]" ]
#set_property PACKAGE_PIN B18  [ get_ports "C0_DDR4_0_dqs_t[3]" ]
#set_property PACKAGE_PIN J20  [ get_ports "C0_DDR4_0_dqs_t[4]" ]
#set_property PACKAGE_PIN D23  [ get_ports "C0_DDR4_0_dqs_t[5]" ]
#set_property PACKAGE_PIN B22  [ get_ports "C0_DDR4_0_dqs_t[6]" ]
#set_property PACKAGE_PIN K21  [ get_ports "C0_DDR4_0_dqs_t[7]" ]
#set_property PACKAGE_PIN H8   [ get_ports "C0_DDR4_0_dqs_t[8]" ] 
#
#set_property PACKAGE_PIN AT5 [ get_ports "reset" ]
#set_property IOSTANDARD LVCMOS33 [ get_ports "reset" ]
#
#set_property PACKAGE_PIN G13 [ get_ports "C0_SYS_CLK_0_clk_p" ]
#set_property IOSTANDARD DIFF_HSTL_I_12 [ get_ports "C0_SYS_CLK_0_clk_p" ]
#
#set_property PACKAGE_PIN G12 [ get_ports "C0_SYS_CLK_0_clk_n" ]
#set_property IOSTANDARD DIFF_HSTL_I_12 [ get_ports "C0_SYS_CLK_0_clk_n" ]

#OpenCPI additions to the above, which is unmodified from the original

create_clock -name clk_fpga_0 -period 10.000 [get_pins -hier * -filter {NAME =~ /ps/U0/inst/PS8_i/PLCLK[0]}]
set_property DONT_TOUCH true [get_cells "ftop/pfconfig_i/zrf8_48dr_i/worker/ps/U0/inst/PS8_i"]

