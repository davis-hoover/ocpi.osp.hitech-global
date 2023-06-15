/*
 * This file is protected by Copyright. Please refer to the COPYRIGHT file
 * distributed with this source distribution.
 *
 * This file is part of OpenCPI <http://www.opencpi.org>
 *
 * OpenCPI is free software: you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * OpenCPI is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * THIS FILE WAS ORIGINALLY GENERATED ON Tue Feb 28 15:42:58 2023 EST
 * BASED ON THE FILE: lmx2594_proxy-rcc.xml
 * YOU *ARE* EXPECTED TO EDIT IT
 *
 * This file contains the implementation skeleton for the lmx2594_proxy worker in C++
 */

#include "lmx2594_proxy-worker.hh"
#include "unistd.h"
#include <iostream>
#include <fstream>
#include <cstring>
#include <string>
#include <iomanip>
#include <sstream>
#include <stdexcept>

using namespace OCPI::RCC; // for easy access to RCC data types and constants
using namespace Lmx2594_proxyWorkerTypes;


class Lmx2594_proxyWorker : public Lmx2594_proxyWorkerBase {
public:
  Lmx2594_proxyWorker() : m_step(1) {
  }
private:
  size_t m_step;
  std::vector<int> m_address_order_list;

  // Convert hex string to integer string
  uint16_t hex_string_to_int(std::string input_hex_string) {
    uint16_t output_int_string;
    std::stringstream ss;
    ss << std::hex << input_hex_string;
    ss >> output_int_string;
    return output_int_string;
  }

  // Convert integer string to interger
  uint16_t string_to_int(std::string input_integer_string) {
    uint16_t output_int;
    std::stringstream ss(input_integer_string);
    ss >> output_int;
    return output_int;
  }

  // Check MUXout_ld_sel
  bool check_muxout_ld_sel(uint16_t data) {
#define MUXOUT_LD_SEL_BIT 0x0004
    return (data & MUXOUT_LD_SEL_BIT) == MUXOUT_LD_SEL_BIT;
  }

  /// @param[in] do_list allows not saving step 6 writes to out_file
  void set_register(int addr, uint16_t data, bool do_list = true) {
    if (do_list) {
      m_address_order_list.push_back(addr);
    }
    access_register(addr, data, true);
  }

  uint16_t get_register(int addr) {
    return access_register(addr, 0, false);
  }

  // Register access gets and sets.
  uint16_t access_register(int addr, uint16_t data, bool set) {
    uint16_t ret = 0;
    if(addr == 0){
      if(set) {
        slave.set_register_0(data);
      }
      else {
        ret = slave.get_register_0();
      }
    }
    else if(addr == 1){
      if(set) {
        slave.set_register_1(data);
      }
      else {
        ret = slave.get_register_1();
      }
    }
    else if(addr == 2){
      if(set) {
        slave.set_register_2(data);
      }
      else {
        ret = slave.get_register_2();
      }
    }
    else if(addr == 3){
      if(set) {
        slave.set_register_3(data);
      }
      else {
        ret = slave.get_register_3();
      }
    }
    else if(addr == 4){
      if(set) {
        slave.set_register_4(data);
      }
      else {
        ret = slave.get_register_4();
      }
    }
    else if(addr == 5){
      if(set) {
        slave.set_register_5(data);
      }
      else {
        ret = slave.get_register_5();
      }
    }
    else if(addr == 6){
      if(set) {
        slave.set_register_6(data);
      }
      else {
        ret = slave.get_register_6();
      }
    }
    else if(addr == 7){
      if(set) {
        slave.set_register_7(data);
      }
      else {
        ret = slave.get_register_7();
      }
    }
    else if(addr == 8){
      if(set) {
        slave.set_register_8(data);
      }
      else {
        ret = slave.get_register_8();
      }
    }
    else if(addr == 9){
      if(set) {
        slave.set_register_9(data);
      }
      else {
        ret = slave.get_register_9();
      }
    }
    else if(addr == 10){
      if(set) {
        slave.set_register_10(data);
      }
      else {
        ret = slave.get_register_10();
      }
    }
    else if(addr == 11){
      if(set) {
        slave.set_register_11(data);
      }
      else {
        ret = slave.get_register_11();
      }
    }
    else if(addr == 12){
      if(set) {
        slave.set_register_12(data);
      }
      else {
        ret = slave.get_register_12();
      }
    }
    else if(addr == 13){
      if(set) {
        slave.set_register_13(data);
      }
      else {
        ret = slave.get_register_13();
      }
    }
    else if(addr == 14){
      if(set) {
        slave.set_register_14(data);
      }
      else {
        ret = slave.get_register_14();
      }
    }
    else if(addr == 15){
      if(set) {
        slave.set_register_15(data);
      }
      else {
        ret = slave.get_register_15();
      }
    }
    else if(addr == 16){
      if(set) {
        slave.set_register_16(data);
      }
      else {
        ret = slave.get_register_16();
      }
    }
    else if(addr == 17){
      if(set) {
        slave.set_register_17(data);
      }
      else {
        ret = slave.get_register_17();
      }
    }
    else if(addr == 18){
      if(set) {
        slave.set_register_18(data);
      }
      else {
        ret = slave.get_register_18();
      }
    }
    else if(addr == 19){
      if(set) {
        slave.set_register_19(data);
      }
      else {
        ret = slave.get_register_19();
      }
    }
    else if(addr == 20){
      if(set) {
        slave.set_register_20(data);
      }
      else {
        ret = slave.get_register_20();
      }
    }
    else if(addr == 21){
      if(set) {
        slave.set_register_21(data);
      }
      else {
        ret = slave.get_register_21();
      }
    }
    else if(addr == 22){
      if(set) {
        slave.set_register_22(data);
      }
      else {
        ret = slave.get_register_22();
      }
    }
    else if(addr == 23){
      if(set) {
        slave.set_register_23(data);
      }
      else {
        ret = slave.get_register_23();
      }
    }
    else if(addr == 24){
      if(set) {
        slave.set_register_24(data);
      }
      else {
        ret = slave.get_register_24();
      }
    }
    else if(addr == 25){
      if(set) {
        slave.set_register_25(data);
      }
      else {
        ret = slave.get_register_25();
      }
    }
    else if(addr == 26){
      if(set) {
        slave.set_register_26(data);
      }
      else {
        ret = slave.get_register_26();
      }
    }
    else if(addr == 27){
      if(set) {
        slave.set_register_27(data);
      }
      else {
        ret = slave.get_register_27();
      }
    }
    else if(addr == 28){
      if(set) {
        slave.set_register_28(data);
      }
      else {
        ret = slave.get_register_28();
      }
    }
    else if(addr == 29){
      if(set) {
        slave.set_register_29(data);
      }
      else {
        ret = slave.get_register_29();
      }
    }
    else if(addr == 30){
      if(set) {
        slave.set_register_30(data);
      }
      else {
        ret = slave.get_register_30();
      }
    }
    else if(addr == 31){
      if(set) {
        slave.set_register_31(data);
      }
      else {
        ret = slave.get_register_31();
      }
    }
    else if(addr == 32){
      if(set) {
        slave.set_register_32(data);
      }
      else {
        ret = slave.get_register_32();
      }
    }
    else if(addr == 33){
      if(set) {
        slave.set_register_33(data);
      }
      else {
        ret = slave.get_register_33();
      }
    }
    else if(addr == 34){
      if(set) {
        slave.set_register_34(data);
      }
      else {
        ret = slave.get_register_34();
      }
    }
    else if(addr == 35){
      if(set) {
        slave.set_register_35(data);
      }
      else {
        ret = slave.get_register_35();
      }
    }
    else if(addr == 36){
      if(set) {
        slave.set_register_36(data);
      }
      else {
        ret = slave.get_register_36();
      }
    }
    else if(addr == 37){
      if(set) {
        slave.set_register_37(data);
      }
      else {
        ret = slave.get_register_37();
      }
    }
    else if(addr == 38){
      if(set) {
        slave.set_register_38(data);
      }
      else {
        ret = slave.get_register_38();
      }
    }
    else if(addr == 39){
      if(set) {
        slave.set_register_39(data);
      }
      else {
        ret = slave.get_register_39();
      }
    }
    else if(addr == 40){
      if(set) {
        slave.set_register_40(data);
      }
      else {
        ret = slave.get_register_40();
      }
    }
    else if(addr == 41){
      if(set) {
        slave.set_register_41(data);
      }
      else {
        ret = slave.get_register_41();
      }
    }
    else if(addr == 42){
      if(set) {
        slave.set_register_42(data);
      }
      else {
        ret = slave.get_register_42();
      }
    }
    else if(addr == 43){
      if(set) {
        slave.set_register_43(data);
      }
      else {
        ret = slave.get_register_43();
      }
    }
    else if(addr == 44){
      if(set) {
        slave.set_register_44(data);
      }
      else {
        ret = slave.get_register_44();
      }
    }
    else if(addr == 45){
      if(set) {
        slave.set_register_45(data);
      }
      else {
        ret = slave.get_register_45();
      }
    }
    else if(addr == 46){
      if(set) {
        slave.set_register_46(data);
      }
      else {
        ret = slave.get_register_46();
      }
    }
    else if(addr == 47){
      if(set) {
        slave.set_register_47(data);
      }
      else {
        ret = slave.get_register_47();
      }
    }
    else if(addr == 48){
      if(set) {
        slave.set_register_48(data);
      }
      else {
        ret = slave.get_register_48();
      }
    }
    else if(addr == 49){
      if(set) {
        slave.set_register_49(data);
      }
      else {
        ret = slave.get_register_49();
      }
    }
    else if(addr == 50){
      if(set) {
        slave.set_register_50(data);
      }
      else {
        ret = slave.get_register_50();
      }
    }
    else if(addr == 51){
      if(set) {
        slave.set_register_51(data);
      }
      else {
        ret = slave.get_register_51();
      }
    }
    else if(addr == 52){
      if(set) {
        slave.set_register_52(data);
      }
      else {
        ret = slave.get_register_52();
      }
    }
    else if(addr == 53){
      if(set) {
        slave.set_register_53(data);
      }
      else {
        ret = slave.get_register_53();
      }
    }
    else if(addr == 54){
      if(set) {
        slave.set_register_54(data);
      }
      else {
        ret = slave.get_register_54();
      }
    }
    else if(addr == 55){
      if(set) {
        slave.set_register_55(data);
      }
      else {
        ret = slave.get_register_55();
      }
    }
    else if(addr == 56){
      if(set) {
        slave.set_register_56(data);
      }
      else {
        ret = slave.get_register_56();
      }
    }
    else if(addr == 57){
      if(set) {
        slave.set_register_57(data);
      }
      else {
        ret = slave.get_register_57();
      }
    }
    else if(addr == 58){
      if(set) {
        slave.set_register_58(data);
      }
      else {
        ret = slave.get_register_58();
      }
    }
    else if(addr == 59){
      if(set) {
        slave.set_register_59(data);
      }
      else {
        ret = slave.get_register_59();
      }
    }
    else if(addr == 60){
      if(set) {
        slave.set_register_60(data);
      }
      else {
        ret = slave.get_register_60();
      }
    }
    else if(addr == 61){
      if(set) {
        slave.set_register_61(data);
      }
      else {
        ret = slave.get_register_61();
      }
    }
    else if(addr == 62){
      if(set) {
        slave.set_register_62(data);
      }
      else {
        ret = slave.get_register_62();
      }
    }
    else if(addr == 63){
      if(set) {
        slave.set_register_63(data);
      }
      else {
        ret = slave.get_register_63();
      }
    }
    else if(addr == 64){
      if(set) {
        slave.set_register_64(data);
      }
      else {
        ret = slave.get_register_64();
      }
    }
    else if(addr == 65){
      if(set) {
        slave.set_register_65(data);
      }
      else {
        ret = slave.get_register_65();
      }
    }
    else if(addr == 66){
      if(set) {
        slave.set_register_66(data);
      }
      else {
        ret = slave.get_register_66();
      }
    }
    else if(addr == 67){
      if(set) {
        slave.set_register_67(data);
      }
      else {
        ret = slave.get_register_67();
      }
    }
    else if(addr == 68){
      if(set) {
        slave.set_register_68(data);
      }
      else {
        ret = slave.get_register_68();
      }
    }
    else if(addr == 69){
      if(set) {
        slave.set_register_69(data);
      }
      else {
        ret = slave.get_register_69();
      }
    }
    else if(addr == 70){
      if(set) {
        slave.set_register_70(data);
      }
      else {
        ret = slave.get_register_70();
      }
    }
    else if(addr == 71){
      if(set) {
        slave.set_register_71(data);
      }
      else {
        ret = slave.get_register_71();
      }
    }
    else if(addr == 72){
      if(set) {
        slave.set_register_72(data);
      }
      else {
        ret = slave.get_register_72();
      }
    }
    else if(addr == 73){
      if(set) {
        slave.set_register_73(data);
      }
      else {
        ret = slave.get_register_73();
      }
    }
    else if(addr == 74){
      if(set) {
        slave.set_register_74(data);
      }
      else {
        ret = slave.get_register_74();
      }
    }
    else if(addr == 75){
      if(set) {
        slave.set_register_75(data);
      }
      else {
        ret = slave.get_register_75();
      }
    }
    else if(addr == 76){
      if(set) {
        slave.set_register_76(data);
      }
      else {
        ret = slave.get_register_76();
      }
    }
    else if(addr == 77){
      if(set) {
        slave.set_register_77(data);
      }
      else {
        ret = slave.get_register_77();
      }
    }
    else if(addr == 78){
      if(set) {
        slave.set_register_78(data);
      }
      else {
        ret = slave.get_register_78();
      }
    }
    else if(addr == 79){
      if(set) {
        slave.set_register_79(data);
      }
      else {
        ret = slave.get_register_79();
      }
    }
    else if(addr == 80){
      if(set) {
        slave.set_register_80(data);
      }
      else {
        ret = slave.get_register_80();
      }
    }
    else if(addr == 81){
      if(set) {
        slave.set_register_81(data);
      }
      else {
        ret = slave.get_register_81();
      }
    }
    else if(addr == 82){
      if(set) {
        slave.set_register_82(data);
      }
      else {
        ret = slave.get_register_82();
      }
    }
    else if(addr == 83){
      if(set) {
        slave.set_register_83(data);
      }
      else {
        ret = slave.get_register_83();
      }
    }
    else if(addr == 84){
      if(set) {
        slave.set_register_84(data);
      }
      else {
        ret = slave.get_register_84();
      }
    }
    else if(addr == 85){
      if(set) {
        slave.set_register_85(data);
      }
      else {
        ret = slave.get_register_85();
      }
    }
    else if(addr == 86){
      if(set) {
        slave.set_register_86(data);
      }
      else {
        ret = slave.get_register_86();
      }
    }
    else if(addr == 87){
      if(set) {
        slave.set_register_87(data);
      }
      else {
        ret = slave.get_register_87();
      }
    }
    else if(addr == 88){
      if(set) {
        slave.set_register_88(data);
      }
      else {
        ret = slave.get_register_88();
      }
    }
    else if(addr == 89){
      if(set) {
        slave.set_register_89(data);
      }
      else {
        ret = slave.get_register_89();
      }
    }
    else if(addr == 90){
      if(set) {
        slave.set_register_90(data);
      }
      else {
        ret = slave.get_register_90();
      }
    }
    else if(addr == 91){
      if(set) {
        slave.set_register_91(data);
      }
      else {
        ret = slave.get_register_91();
      }
    }
    else if(addr == 92){
      if(set) {
        slave.set_register_92(data);
      }
      else {
        ret = slave.get_register_92();
      }
    }
    else if(addr == 93){
      if(set) {
        slave.set_register_93(data);
      }
      else {
        ret = slave.get_register_93();
      }
    }
    else if(addr == 94){
      if(set) {
        slave.set_register_94(data);
      }
      else {
        ret = slave.get_register_94();
      }
    }
    else if(addr == 95){
      if(set) {
        slave.set_register_95(data);
      }
      else {
        ret = slave.get_register_95();
      }
    }
    else if(addr == 96){
      if(set) {
        slave.set_register_96(data);
      }
      else {
        ret = slave.get_register_96();
      }
    }
    else if(addr == 97){
      if(set) {
        slave.set_register_97(data);
      }
      else {
        ret = slave.get_register_97();
      }
    }
    else if(addr == 98){
      if(set) {
        slave.set_register_98(data);
      }
      else {
        ret = slave.get_register_98();
      }
    }
    else if(addr == 99){
      if(set) {
        slave.set_register_99(data);
      }
      else {
        ret = slave.get_register_99();
      }
    }
    else if(addr == 100){
      if(set) {
        slave.set_register_100(data);
      }
      else {
        ret = slave.get_register_100();
      }
    }
    else if(addr == 101){
      if(set) {
        slave.set_register_101(data);
      }
      else {
        ret = slave.get_register_101();
      }
    }
    else if(addr == 102){
      if(set) {
        slave.set_register_102(data);
      }
      else {
        ret = slave.get_register_102();
      }
    }
    else if(addr == 103){
      if(set) {
        slave.set_register_103(data);
      }
      else {
        ret = slave.get_register_103();
      }
    }
    else if(addr == 104){
      if(set) {
        slave.set_register_104(data);
      }
      else {
        ret = slave.get_register_104();
      }
    }
    else if(addr == 105){
      if(set) {
        slave.set_register_105(data);
      }
      else {
        ret = slave.get_register_105();
      }
    }
    else if(addr == 106){
      if(set) {
        slave.set_register_106(data);
      }
      else {
        ret = slave.get_register_106();
      }
    }
    else if (set) {
      throw std::runtime_error("attempted writing a non-writable register");
    }
    else {
      if(addr == 107){
        ret = slave.get_register_107();
      }
      else if(addr == 108){
        ret = slave.get_register_108();
      }
      else if(addr == 109){
        ret = slave.get_register_109();
      }
      else if(addr == 110){
        ret = slave.get_register_110();
      }
      else if(addr == 111){
        ret = slave.get_register_111();
      }
      else if(addr == 112){
        ret = slave.get_register_112();
      }
      else {
        throw std::runtime_error("invalid register address");
      }
    }
    return ret;
  }
  
  void perform_datasheet_section_7_5_1_step_2() {
    log(8, "performing step 2. Program RESET = 1 to reset registers.");
    m_step = 2;
    slave.set_register_0(0x2412);
  }

  void perform_datasheet_section_7_5_1_step_3() {
    log(8, "performing step 3. Program RESET = 0 to remove reset.");
    m_step = 3;
    slave.set_register_0(0x2410);
  }

  void set_step_to_4_and_log() {
    log(8, "performing step 4. Program registers as shown in the register map in REVERSE order from highest to lowest.");
    m_step = 4;
  }

  void perform_datasheet_section_7_5_1_step_4(
      const std::string& tics_pro_filename) {
    log(8, "using file configuration mode");
    set_step_to_4_and_log();
    uint16_t address_length;
    std::size_t data_length = 4;
    uint16_t addr_int;
    uint16_t data_int;
    std::string reg_data_line;
    std::string addr_string;
    std::string data_string;
    // Open TICSPRO txt file
    std::ifstream register_file;
    register_file.open(tics_pro_filename);
    if (register_file.is_open()) {
      std::size_t chars_to_data;
      std::size_t chars_to_addr;
      // Convert each file line addr/data values
      while(std::getline(register_file, reg_data_line)) {
        chars_to_addr = reg_data_line.find("R"); // Always 0
        chars_to_data = reg_data_line.find("x"); // Dependent on Address Length
        // Address Values
        // if 3 Digit Register Address
        if(chars_to_data == 6) {
          address_length = 3;
          char address[address_length];
          reg_data_line.copy(address, 3, chars_to_addr + 1);
          address[address_length]='\0';
          addr_string = address;
          addr_int = string_to_int(addr_string);
        }
        // else if 2 Digit Register Address
        else if(chars_to_data == 5) {
          address_length = 2;
          char address[address_length];
          reg_data_line.copy(address, 2, chars_to_addr + 1);
          address[address_length]='\0';
          addr_string = address;
          addr_int = string_to_int(addr_string);
        }
        // else 1 Digit Register Address
        else {
          address_length = 1;
          char address[address_length];
          reg_data_line.copy(address, 1, chars_to_addr + 1);
          address[address_length]='\0';
          addr_string = address;
          addr_int = string_to_int(addr_string);
        }
        // Data Values
        char data[data_length];
        reg_data_line.copy(data, 4, chars_to_data + 3);
        data[data_length]='\0';
        data_string = data;
        data_int = hex_string_to_int(data_string);

        // Set register
        if (addr_int == 0) {
          // clear muxout_ld_sel to be able to properly read registers
          data_int &= ~MUXOUT_LD_SEL_BIT;
        }
        set_register(addr_int, data_int);
      }
    }
    else {
      throw std::runtime_error("ERROR: in_filename was specified but could not be opened");
    }
  }

  void perform_datasheet_section_7_5_1_step_5() {
    log(8, "performing step 5. Wait 10 ms.");
    m_step = 5;
    usleep(10e3);
  }

  void perform_datasheet_section_7_5_1_step_6() {
    log(8, "performing step 6. Program register R0 one additional time with FCAL_EN = 1 to ensure that the VCO calibration runs from a stable state.");
    m_step = 6;
#define FCAL_EN_BIT (1 << 3)
    m_properties.register_0 = get_register(0);
    m_properties.register_0 |= FCAL_EN_BIT;
    set_register(0, m_properties.register_0, false);
  }

  /// @brief intended to be called just after perform_datasheet_section_7_5_1_step_6()
  bool get_pll_locked() {
    m_properties.register_110 = get_register(110);
    bool ret = ((m_properties.register_110 & 0x0600) == 0x0400);
    if (ret) {
      log(8, "PLL locked");
    }
    return ret;
  }

  // Construct out_filename property to recreate TICSPRO structure
  void apply_out_filename_property() {
    std::ofstream outfile(properties().out_filename);
    // Get registers after they've been set using list
    for(auto it=m_address_order_list.begin(); it!=m_address_order_list.end(); ++it) {
      // Get Address
      uint16_t addr_value = *it;
      std::string addr_string;
      std::stringstream ss_addr;

      // Get Data
      uint16_t get_data_value = get_register(*it); // Get register
      std::string data_string;
      std::stringstream ss_data;

      // Append out_filename
      // If address 0, reselect muxout_ld_sel bit
      if(*it == 0) {
        ss_addr << std::uppercase << std::setfill('0') << std::setw(2) << std::hex << addr_value;
        addr_string = ss_addr.str();

        // Reselect muxout_ld_sel bit
        get_data_value |= MUXOUT_LD_SEL_BIT;
        ss_data << std::uppercase << std::setfill('0') << std::setw(4) << std::hex << get_data_value;
        data_string = ss_data.str();

        // Dump gets to outfile property in the same format as TICSPRO file
        std::streambuf* coutbuf = std::cout.rdbuf();
        std::cout.rdbuf(outfile.rdbuf());
        std::cout << "R" << *it << "\t0x" << addr_string << data_string << "\r" << std::endl;
        std::cout.rdbuf(coutbuf);
      }
      // Else all other registers
      else {
        ss_addr << std::uppercase << std::setfill('0') << std::setw(2) << std::hex << addr_value;
        addr_string = ss_addr.str();

        ss_data << std::uppercase << std::setfill('0') << std::setw(4) << std::hex << get_data_value;
        data_string = ss_data.str();

        // Dump gets to outfile property in the same format as TICSPRO file
        std::streambuf* coutbuf = std::cout.rdbuf();
        std::cout.rdbuf(outfile.rdbuf());
        std::cout << "R" << *it << "\t0x" << addr_string << data_string << "\r" << std::endl;
        std::cout.rdbuf(coutbuf);
      }
    }
    outfile.close();
  }

  RCCResult start() {
    RCCResult ret = RCC_OK;
    try {
      // https://www.ti.com/lit/ds/symlink/lmx2594.pdf section 7.5.1
      if (!std::string(properties().in_filename).empty()) {
        perform_datasheet_section_7_5_1_step_2();
        perform_datasheet_section_7_5_1_step_3();
        perform_datasheet_section_7_5_1_step_4(properties().in_filename);
      }
      else {
        // steps 2, 3, and 4 were already performed during register_ write
        // callbacks
        if (m_step < 4) {
          throw std::runtime_error("ERROR: property mode requested but no register_* property was written");
        }
      }  
      perform_datasheet_section_7_5_1_step_5();
      perform_datasheet_section_7_5_1_step_6();
      /// @TODO confirm datasheet settling time and shorten from 1 sec
      sleep(1);
      bool pll_locked = get_pll_locked();
      apply_out_filename_property(); // must apply before throw
      if (!pll_locked) {
        throw std::runtime_error("ERROR: PLL failed to lock");
      }
    }
    catch (std::runtime_error& err) {
      log(8, "%s", err.what());
      ret = RCC_ERROR;
    }
    return ret;
  }

  /*! @brief this allows the register_ properties to be written in the same
   *         way a TICs PRO output file would be used, but intelligently applies
   *         datasheet section 7.5.1 steps 2 and 3 before, and only before, the
   *         *first* register_ property write occurs (regardless of which
   *         property is written first)
   *  @return true if register should be written
   ****************************************************************************/
  bool perform_register_written_pre_actions() {
    bool ret = false;
    if(std::string(properties().in_filename).empty()) {
      if (m_step < 3) {
        log(8, "using property configuration mode");
        for (int idx = 112; idx >= 107; idx--) {
          // this is a silly thing that makes out_file behavior for property
          // configuration mode match that of file configuration mode
          m_address_order_list.push_back(idx);
        }
        perform_datasheet_section_7_5_1_step_2();
        perform_datasheet_section_7_5_1_step_3();
        set_step_to_4_and_log();
      }
      ret = true;
    }
    return ret;
  }

  // notification that register_0 property has been written
  RCCResult register_0_written() {
    if (perform_register_written_pre_actions()) {
      set_register(0, m_properties.register_0);
    }
    return RCC_OK;
  }
  // notification that register_0 property will be read
  RCCResult register_0_read() {
    m_properties.register_0 = slave.get_register_0();
    return RCC_OK;
  }
  // notification that register_1 property has been written
  RCCResult register_1_written() {
    if (perform_register_written_pre_actions()) {
      set_register(1, m_properties.register_1);
    }
    return RCC_OK;
  }
  // notification that register_1 property will be read
  RCCResult register_1_read() {
    m_properties.register_1 = slave.get_register_1();
    return RCC_OK;
  }
  // notification that register_2 property has been written
  RCCResult register_2_written() {
    if (perform_register_written_pre_actions()) {
      set_register(2, m_properties.register_2);
    }
    return RCC_OK;
  }
  // notification that register_2 property will be read
  RCCResult register_2_read() {
    m_properties.register_2 = slave.get_register_2();
    return RCC_OK;
  }
  // notification that register_3 property has been written
  RCCResult register_3_written() {
    if (perform_register_written_pre_actions()) {
      set_register(3, m_properties.register_3);
    }
    return RCC_OK;
  }
  // notification that register_3 property will be read
  RCCResult register_3_read() {
    m_properties.register_3 = slave.get_register_3();
    return RCC_OK;
  }
  // notification that register_4 property has been written
  RCCResult register_4_written() {
    if (perform_register_written_pre_actions()) {
      set_register(4, m_properties.register_4);
    }
    return RCC_OK;
  }
  // notification that register_4 property will be read
  RCCResult register_4_read() {
    m_properties.register_4 = slave.get_register_4();
    return RCC_OK;
  }
  // notification that register_5 property has been written
  RCCResult register_5_written() {
    if (perform_register_written_pre_actions()) {
      set_register(5, m_properties.register_5);
    }
    return RCC_OK;
  }
  // notification that register_5 property will be read
  RCCResult register_5_read() {
    m_properties.register_5 = slave.get_register_5();
    return RCC_OK;
  }
  // notification that register_6 property has been written
  RCCResult register_6_written() {
    if (perform_register_written_pre_actions()) {
      set_register(6, m_properties.register_6);
    }
    return RCC_OK;
  }
  // notification that register_6 property will be read
  RCCResult register_6_read() {
    m_properties.register_6 = slave.get_register_6();
    return RCC_OK;
  }
  // notification that register_7 property has been written
  RCCResult register_7_written() {
    if (perform_register_written_pre_actions()) {
      set_register(7, m_properties.register_7);
    }
    return RCC_OK;
  }
  // notification that register_7 property will be read
  RCCResult register_7_read() {
    m_properties.register_7 = slave.get_register_7();
    return RCC_OK;
  }
  // notification that register_8 property has been written
  RCCResult register_8_written() {
    if (perform_register_written_pre_actions()) {
      set_register(8, m_properties.register_8);
    }
    return RCC_OK;
  }
  // notification that register_8 property will be read
  RCCResult register_8_read() {
    m_properties.register_8 = slave.get_register_8();
    return RCC_OK;
  }
  // notification that register_9 property has been written
  RCCResult register_9_written() {
    if (perform_register_written_pre_actions()) {
      set_register(9, m_properties.register_9);
    }
    return RCC_OK;
  }
  // notification that register_9 property will be read
  RCCResult register_9_read() {
    m_properties.register_9 = slave.get_register_9();
    return RCC_OK;
  }
  // notification that register_10 property has been written
  RCCResult register_10_written() {
    if (perform_register_written_pre_actions()) {
      set_register(10, m_properties.register_10);
    }
    return RCC_OK;
  }
  // notification that register_10 property will be read
  RCCResult register_10_read() {
    m_properties.register_10 = slave.get_register_10();
    return RCC_OK;
  }
  // notification that register_11 property has been written
  RCCResult register_11_written() {
    if (perform_register_written_pre_actions()) {
      set_register(11, m_properties.register_11);
    }
    return RCC_OK;
  }
  // notification that register_11 property will be read
  RCCResult register_11_read() {
    m_properties.register_11 = slave.get_register_11();
    return RCC_OK;
  }
  // notification that register_12 property has been written
  RCCResult register_12_written() {
    if (perform_register_written_pre_actions()) {
      set_register(12, m_properties.register_12);
    }
    return RCC_OK;
  }
  // notification that register_12 property will be read
  RCCResult register_12_read() {
    m_properties.register_12 = slave.get_register_12();
    return RCC_OK;
  }
  // notification that register_13 property has been written
  RCCResult register_13_written() {
    if (perform_register_written_pre_actions()) {
      set_register(13, m_properties.register_13);
    }
    return RCC_OK;
  }
  // notification that register_13 property will be read
  RCCResult register_13_read() {
    m_properties.register_13 = slave.get_register_13();
    return RCC_OK;
  }
  // notification that register_14 property has been written
  RCCResult register_14_written() {
    if (perform_register_written_pre_actions()) {
      set_register(14, m_properties.register_14);
    }
    return RCC_OK;
  }
  // notification that register_14 property will be read
  RCCResult register_14_read() {
    m_properties.register_14 = slave.get_register_14();
    return RCC_OK;
  }
  // notification that register_15 property has been written
  RCCResult register_15_written() {
    if (perform_register_written_pre_actions()) {
      set_register(15, m_properties.register_15);
    }
    return RCC_OK;
  }
  // notification that register_15 property will be read
  RCCResult register_15_read() {
    m_properties.register_15 = slave.get_register_15();
    return RCC_OK;
  }
  // notification that register_16 property has been written
  RCCResult register_16_written() {
    if (perform_register_written_pre_actions()) {
      set_register(16, m_properties.register_16);
    }
    return RCC_OK;
  }
  // notification that register_16 property will be read
  RCCResult register_16_read() {
    m_properties.register_16 = slave.get_register_16();
    return RCC_OK;
  }
  // notification that register_17 property has been written
  RCCResult register_17_written() {
    if (perform_register_written_pre_actions()) {
      set_register(17, m_properties.register_17);
    }
    return RCC_OK;
  }
  // notification that register_17 property will be read
  RCCResult register_17_read() {
    m_properties.register_17 = slave.get_register_17();
    return RCC_OK;
  }
  // notification that register_18 property has been written
  RCCResult register_18_written() {
    if (perform_register_written_pre_actions()) {
      set_register(18, m_properties.register_18);
    }
    return RCC_OK;
  }
  // notification that register_18 property will be read
  RCCResult register_18_read() {
    m_properties.register_18 = slave.get_register_18();
    return RCC_OK;
  }
  // notification that register_19 property has been written
  RCCResult register_19_written() {
    if (perform_register_written_pre_actions()) {
      set_register(19, m_properties.register_19);
    }
    return RCC_OK;
  }
  // notification that register_19 property will be read
  RCCResult register_19_read() {
    m_properties.register_19 = slave.get_register_19();
    return RCC_OK;
  }
  // notification that register_20 property has been written
  RCCResult register_20_written() {
    if (perform_register_written_pre_actions()) {
      set_register(20, m_properties.register_20);
    }
    return RCC_OK;
  }
  // notification that register_20 property will be read
  RCCResult register_20_read() {
    m_properties.register_20 = slave.get_register_20();
    return RCC_OK;
  }
  // notification that register_21 property has been written
  RCCResult register_21_written() {
    if (perform_register_written_pre_actions()) {
      set_register(21, m_properties.register_21);
    }
    return RCC_OK;
  }
  // notification that register_21 property will be read
  RCCResult register_21_read() {
    m_properties.register_21 = slave.get_register_21();
    return RCC_OK;
  }
  // notification that register_22 property has been written
  RCCResult register_22_written() {
    if (perform_register_written_pre_actions()) {
      set_register(22, m_properties.register_22);
    }
    return RCC_OK;
  }
  // notification that register_22 property will be read
  RCCResult register_22_read() {
    m_properties.register_22 = slave.get_register_22();
    return RCC_OK;
  }
  // notification that register_23 property has been written
  RCCResult register_23_written() {
    if (perform_register_written_pre_actions()) {
      set_register(23, m_properties.register_23);
    }
    return RCC_OK;
  }
  // notification that register_23 property will be read
  RCCResult register_23_read() {
    m_properties.register_23 = slave.get_register_23();
    return RCC_OK;
  }
  // notification that register_24 property has been written
  RCCResult register_24_written() {
    if (perform_register_written_pre_actions()) {
      set_register(24, m_properties.register_24);
    }
    return RCC_OK;
  }
  // notification that register_24 property will be read
  RCCResult register_24_read() {
    m_properties.register_24 = slave.get_register_24();
    return RCC_OK;
  }
  // notification that register_25 property has been written
  RCCResult register_25_written() {
    if (perform_register_written_pre_actions()) {
      set_register(25, m_properties.register_25);
    }
    return RCC_OK;
  }
  // notification that register_25 property will be read
  RCCResult register_25_read() {
    m_properties.register_25 = slave.get_register_25();
    return RCC_OK;
  }
  // notification that register_26 property has been written
  RCCResult register_26_written() {
    if (perform_register_written_pre_actions()) {
      set_register(26, m_properties.register_26);
    }
    return RCC_OK;
  }
  // notification that register_26 property will be read
  RCCResult register_26_read() {
    m_properties.register_26 = slave.get_register_26();
    return RCC_OK;
  }
  // notification that register_27 property has been written
  RCCResult register_27_written() {
    if (perform_register_written_pre_actions()) {
      set_register(27, m_properties.register_27);
    }
    return RCC_OK;
  }
  // notification that register_27 property will be read
  RCCResult register_27_read() {
    m_properties.register_27 = slave.get_register_27();
    return RCC_OK;
  }
  // notification that register_28 property has been written
  RCCResult register_28_written() {
    if (perform_register_written_pre_actions()) {
      set_register(28, m_properties.register_28);
    }
    return RCC_OK;
  }
  // notification that register_28 property will be read
  RCCResult register_28_read() {
    m_properties.register_28 = slave.get_register_28();
    return RCC_OK;
  }
  // notification that register_29 property has been written
  RCCResult register_29_written() {
    if (perform_register_written_pre_actions()) {
      set_register(29, m_properties.register_29);
    }
    return RCC_OK;
  }
  // notification that register_29 property will be read
  RCCResult register_29_read() {
    m_properties.register_29 = slave.get_register_29();
    return RCC_OK;
  }
  // notification that register_30 property has been written
  RCCResult register_30_written() {
    if (perform_register_written_pre_actions()) {
      set_register(30, m_properties.register_30);
    }
    return RCC_OK;
  }
  // notification that register_30 property will be read
  RCCResult register_30_read() {
    m_properties.register_30 = slave.get_register_30();
    return RCC_OK;
  }
  // notification that register_31 property has been written
  RCCResult register_31_written() {
    if (perform_register_written_pre_actions()) {
      set_register(31, m_properties.register_31);
    }
    return RCC_OK;
  }
  // notification that register_31 property will be read
  RCCResult register_31_read() {
    m_properties.register_31 = slave.get_register_31();
    return RCC_OK;
  }
  // notification that register_32 property has been written
  RCCResult register_32_written() {
    if (perform_register_written_pre_actions()) {
      set_register(32, m_properties.register_32);
    }
    return RCC_OK;
  }
  // notification that register_32 property will be read
  RCCResult register_32_read() {
    m_properties.register_32 = slave.get_register_32();
    return RCC_OK;
  }
  // notification that register_33 property has been written
  RCCResult register_33_written() {
    if (perform_register_written_pre_actions()) {
      set_register(33, m_properties.register_33);
    }
    return RCC_OK;
  }
  // notification that register_33 property will be read
  RCCResult register_33_read() {
    m_properties.register_33 = slave.get_register_33();
    return RCC_OK;
  }
  // notification that register_34 property has been written
  RCCResult register_34_written() {
    if (perform_register_written_pre_actions()) {
      set_register(34, m_properties.register_34);
    }
    return RCC_OK;
  }
  // notification that register_34 property will be read
  RCCResult register_34_read() {
    m_properties.register_34 = slave.get_register_34();
    return RCC_OK;
  }
  // notification that register_35 property has been written
  RCCResult register_35_written() {
    if (perform_register_written_pre_actions()) {
      set_register(35, m_properties.register_35);
    }
    return RCC_OK;
  }
  // notification that register_35 property will be read
  RCCResult register_35_read() {
    m_properties.register_35 = slave.get_register_35();
    return RCC_OK;
  }
  // notification that register_36 property has been written
  RCCResult register_36_written() {
    if (perform_register_written_pre_actions()) {
      set_register(36, m_properties.register_36);
    }
    return RCC_OK;
  }
  // notification that register_36 property will be read
  RCCResult register_36_read() {
    m_properties.register_36 = slave.get_register_36();
    return RCC_OK;
  }
  // notification that register_37 property has been written
  RCCResult register_37_written() {
    if (perform_register_written_pre_actions()) {
      set_register(37, m_properties.register_37);
    }
    return RCC_OK;
  }
  // notification that register_37 property will be read
  RCCResult register_37_read() {
    m_properties.register_37 = slave.get_register_37();
    return RCC_OK;
  }
  // notification that register_38 property has been written
  RCCResult register_38_written() {
    if (perform_register_written_pre_actions()) {
      set_register(38, m_properties.register_38);
    }
    return RCC_OK;
  }
  // notification that register_38 property will be read
  RCCResult register_38_read() {
    m_properties.register_38 = slave.get_register_38();
    return RCC_OK;
  }
  // notification that register_39 property has been written
  RCCResult register_39_written() {
    if (perform_register_written_pre_actions()) {
      set_register(39, m_properties.register_39);
    }
    return RCC_OK;
  }
  // notification that register_39 property will be read
  RCCResult register_39_read() {
    m_properties.register_39 = slave.get_register_39();
    return RCC_OK;
  }
  // notification that register_40 property has been written
  RCCResult register_40_written() {
    if (perform_register_written_pre_actions()) {
      set_register(40, m_properties.register_40);
    }
    return RCC_OK;
  }
  // notification that register_40 property will be read
  RCCResult register_40_read() {
    m_properties.register_40 = slave.get_register_40();
    return RCC_OK;
  }
  // notification that register_41 property has been written
  RCCResult register_41_written() {
    if (perform_register_written_pre_actions()) {
      set_register(41, m_properties.register_41);
    }
    return RCC_OK;
  }
  // notification that register_41 property will be read
  RCCResult register_41_read() {
    m_properties.register_41 = slave.get_register_41();
    return RCC_OK;
  }
  // notification that register_42 property has been written
  RCCResult register_42_written() {
    if (perform_register_written_pre_actions()) {
      set_register(42, m_properties.register_42);
    }
    return RCC_OK;
  }
  // notification that register_42 property will be read
  RCCResult register_42_read() {
    m_properties.register_42 = slave.get_register_42();
    return RCC_OK;
  }
  // notification that register_43 property has been written
  RCCResult register_43_written() {
    if (perform_register_written_pre_actions()) {
      set_register(43, m_properties.register_43);
    }
    return RCC_OK;
  }
  // notification that register_43 property will be read
  RCCResult register_43_read() {
    m_properties.register_43 = slave.get_register_43();
    return RCC_OK;
  }
  // notification that register_44 property has been written
  RCCResult register_44_written() {
    if (perform_register_written_pre_actions()) {
      set_register(44, m_properties.register_44);
    }
    return RCC_OK;
  }
  // notification that register_44 property will be read
  RCCResult register_44_read() {
    m_properties.register_44 = slave.get_register_44();
    return RCC_OK;
  }
  // notification that register_45 property has been written
  RCCResult register_45_written() {
    if (perform_register_written_pre_actions()) {
      set_register(45, m_properties.register_45);
    }
    return RCC_OK;
  }
  // notification that register_45 property will be read
  RCCResult register_45_read() {
    m_properties.register_45 = slave.get_register_45();
    return RCC_OK;
  }
  // notification that register_46 property has been written
  RCCResult register_46_written() {
    if (perform_register_written_pre_actions()) {
      set_register(46, m_properties.register_46);
    }
    return RCC_OK;
  }
  // notification that register_46 property will be read
  RCCResult register_46_read() {
    m_properties.register_46 = slave.get_register_46();
    return RCC_OK;
  }
  // notification that register_47 property has been written
  RCCResult register_47_written() {
    if (perform_register_written_pre_actions()) {
      set_register(47, m_properties.register_47);
    }
    return RCC_OK;
  }
  // notification that register_47 property will be read
  RCCResult register_47_read() {
    m_properties.register_47 = slave.get_register_47();
    return RCC_OK;
  }
  // notification that register_48 property has been written
  RCCResult register_48_written() {
    if (perform_register_written_pre_actions()) {
      set_register(48, m_properties.register_48);
    }
    return RCC_OK;
  }
  // notification that register_48 property will be read
  RCCResult register_48_read() {
    m_properties.register_48 = slave.get_register_48();
    return RCC_OK;
  }
  // notification that register_49 property has been written
  RCCResult register_49_written() {
    if (perform_register_written_pre_actions()) {
      set_register(49, m_properties.register_49);
    }
    return RCC_OK;
  }
  // notification that register_49 property will be read
  RCCResult register_49_read() {
    m_properties.register_49 = slave.get_register_49();
    return RCC_OK;
  }
  // notification that register_50 property has been written
  RCCResult register_50_written() {
    if (perform_register_written_pre_actions()) {
      set_register(50, m_properties.register_50);
    }
    return RCC_OK;
  }
  // notification that register_50 property will be read
  RCCResult register_50_read() {
    m_properties.register_50 = slave.get_register_50();
    return RCC_OK;
  }
  // notification that register_51 property has been written
  RCCResult register_51_written() {
    if (perform_register_written_pre_actions()) {
      set_register(51, m_properties.register_51);
    }
    return RCC_OK;
  }
  // notification that register_51 property will be read
  RCCResult register_51_read() {
    m_properties.register_51 = slave.get_register_51();
    return RCC_OK;
  }
  // notification that register_52 property has been written
  RCCResult register_52_written() {
    if (perform_register_written_pre_actions()) {
      set_register(52, m_properties.register_52);
    }
    return RCC_OK;
  }
  // notification that register_52 property will be read
  RCCResult register_52_read() {
    m_properties.register_52 = slave.get_register_52();
    return RCC_OK;
  }
  // notification that register_53 property has been written
  RCCResult register_53_written() {
    if (perform_register_written_pre_actions()) {
      set_register(53, m_properties.register_53);
    }
    return RCC_OK;
  }
  // notification that register_53 property will be read
  RCCResult register_53_read() {
    m_properties.register_53 = slave.get_register_53();
    return RCC_OK;
  }
  // notification that register_54 property has been written
  RCCResult register_54_written() {
    if (perform_register_written_pre_actions()) {
      set_register(54, m_properties.register_54);
    }
    return RCC_OK;
  }
  // notification that register_54 property will be read
  RCCResult register_54_read() {
    m_properties.register_54 = slave.get_register_54();
    return RCC_OK;
  }
  // notification that register_55 property has been written
  RCCResult register_55_written() {
    if (perform_register_written_pre_actions()) {
      set_register(55, m_properties.register_55);
    }
    return RCC_OK;
  }
  // notification that register_55 property will be read
  RCCResult register_55_read() {
    m_properties.register_55 = slave.get_register_55();
    return RCC_OK;
  }
  // notification that register_56 property has been written
  RCCResult register_56_written() {
    if (perform_register_written_pre_actions()) {
      set_register(56, m_properties.register_56);
    }
    return RCC_OK;
  }
  // notification that register_56 property will be read
  RCCResult register_56_read() {
    m_properties.register_56 = slave.get_register_56();
    return RCC_OK;
  }
  // notification that register_57 property has been written
  RCCResult register_57_written() {
    if (perform_register_written_pre_actions()) {
      set_register(57, m_properties.register_57);
    }
    return RCC_OK;
  }
  // notification that register_57 property will be read
  RCCResult register_57_read() {
    m_properties.register_57 = slave.get_register_57();
    return RCC_OK;
  }
  // notification that register_58 property has been written
  RCCResult register_58_written() {
    if (perform_register_written_pre_actions()) {
      set_register(58, m_properties.register_58);
    }
    return RCC_OK;
  }
  // notification that register_58 property will be read
  RCCResult register_58_read() {
    m_properties.register_58 = slave.get_register_58();
    return RCC_OK;
  }
  // notification that register_59 property has been written
  RCCResult register_59_written() {
    if (perform_register_written_pre_actions()) {
      set_register(59, m_properties.register_59);
    }
    return RCC_OK;
  }
  // notification that register_59 property will be read
  RCCResult register_59_read() {
    m_properties.register_59 = slave.get_register_59();
    return RCC_OK;
  }
  // notification that register_60 property has been written
  RCCResult register_60_written() {
    if (perform_register_written_pre_actions()) {
      set_register(60, m_properties.register_60);
    }
    return RCC_OK;
  }
  // notification that register_60 property will be read
  RCCResult register_60_read() {
    m_properties.register_60 = slave.get_register_60();
    return RCC_OK;
  }
  // notification that register_61 property has been written
  RCCResult register_61_written() {
    if (perform_register_written_pre_actions()) {
      set_register(61, m_properties.register_61);
    }
    return RCC_OK;
  }
  // notification that register_61 property will be read
  RCCResult register_61_read() {
    m_properties.register_61 = slave.get_register_61();
    return RCC_OK;
  }
  // notification that register_62 property has been written
  RCCResult register_62_written() {
    if (perform_register_written_pre_actions()) {
      set_register(62, m_properties.register_62);
    }
    return RCC_OK;
  }
  // notification that register_62 property will be read
  RCCResult register_62_read() {
    m_properties.register_62 = slave.get_register_62();
    return RCC_OK;
  }
  // notification that register_63 property has been written
  RCCResult register_63_written() {
    if (perform_register_written_pre_actions()) {
      set_register(63, m_properties.register_63);
    }
    return RCC_OK;
  }
  // notification that register_63 property will be read
  RCCResult register_63_read() {
    m_properties.register_63 = slave.get_register_63();
    return RCC_OK;
  }
  // notification that register_64 property has been written
  RCCResult register_64_written() {
    if (perform_register_written_pre_actions()) {
      set_register(64, m_properties.register_64);
    }
    return RCC_OK;
  }
  // notification that register_64 property will be read
  RCCResult register_64_read() {
    m_properties.register_64 = slave.get_register_64();
    return RCC_OK;
  }
  // notification that register_65 property has been written
  RCCResult register_65_written() {
    if (perform_register_written_pre_actions()) {
      set_register(65, m_properties.register_65);
    }
    return RCC_OK;
  }
  // notification that register_65 property will be read
  RCCResult register_65_read() {
    m_properties.register_65 = slave.get_register_65();
    return RCC_OK;
  }
  // notification that register_66 property has been written
  RCCResult register_66_written() {
    if (perform_register_written_pre_actions()) {
      set_register(66, m_properties.register_66);
    }
    return RCC_OK;
  }
  // notification that register_66 property will be read
  RCCResult register_66_read() {
    m_properties.register_66 = slave.get_register_66();
    return RCC_OK;
  }
  // notification that register_67 property has been written
  RCCResult register_67_written() {
    if (perform_register_written_pre_actions()) {
      set_register(67, m_properties.register_67);
    }
    return RCC_OK;
  }
  // notification that register_67 property will be read
  RCCResult register_67_read() {
    m_properties.register_67 = slave.get_register_67();
    return RCC_OK;
  }
  // notification that register_68 property has been written
  RCCResult register_68_written() {
    if (perform_register_written_pre_actions()) {
      set_register(68, m_properties.register_68);
    }
    return RCC_OK;
  }
  // notification that register_68 property will be read
  RCCResult register_68_read() {
    m_properties.register_68 = slave.get_register_68();
    return RCC_OK;
  }
  // notification that register_69 property has been written
  RCCResult register_69_written() {
    if (perform_register_written_pre_actions()) {
      set_register(69, m_properties.register_69);
    }
    return RCC_OK;
  }
  // notification that register_69 property will be read
  RCCResult register_69_read() {
    m_properties.register_69 = slave.get_register_69();
    return RCC_OK;
  }
  // notification that register_70 property has been written
  RCCResult register_70_written() {
    if (perform_register_written_pre_actions()) {
      set_register(70, m_properties.register_70);
    }
    return RCC_OK;
  }
  // notification that register_70 property will be read
  RCCResult register_70_read() {
    m_properties.register_70 = slave.get_register_70();
    return RCC_OK;
  }
  // notification that register_71 property has been written
  RCCResult register_71_written() {
    if (perform_register_written_pre_actions()) {
      set_register(71, m_properties.register_71);
    }
    return RCC_OK;
  }
  // notification that register_71 property will be read
  RCCResult register_71_read() {
    m_properties.register_71 = slave.get_register_71();
    return RCC_OK;
  }
  // notification that register_72 property has been written
  RCCResult register_72_written() {
    if (perform_register_written_pre_actions()) {
      set_register(72, m_properties.register_72);
    }
    return RCC_OK;
  }
  // notification that register_72 property will be read
  RCCResult register_72_read() {
    m_properties.register_72 = slave.get_register_72();
    return RCC_OK;
  }
  // notification that register_73 property has been written
  RCCResult register_73_written() {
    if (perform_register_written_pre_actions()) {
      set_register(73, m_properties.register_73);
    }
    return RCC_OK;
  }
  // notification that register_73 property will be read
  RCCResult register_73_read() {
    m_properties.register_73 = slave.get_register_73();
    return RCC_OK;
  }
  // notification that register_74 property has been written
  RCCResult register_74_written() {
    if (perform_register_written_pre_actions()) {
      set_register(74, m_properties.register_74);
    }
    return RCC_OK;
  }
  // notification that register_74 property will be read
  RCCResult register_74_read() {
    m_properties.register_74 = slave.get_register_74();
    return RCC_OK;
  }
  // notification that register_75 property has been written
  RCCResult register_75_written() {
    if (perform_register_written_pre_actions()) {
      set_register(75, m_properties.register_75);
    }
    return RCC_OK;
  }
  // notification that register_75 property will be read
  RCCResult register_75_read() {
    m_properties.register_75 = slave.get_register_75();
    return RCC_OK;
  }
  // notification that register_76 property has been written
  RCCResult register_76_written() {
    if (perform_register_written_pre_actions()) {
      set_register(76, m_properties.register_76);
    }
    return RCC_OK;
  }
  // notification that register_76 property will be read
  RCCResult register_76_read() {
    m_properties.register_76 = slave.get_register_76();
    return RCC_OK;
  }
  // notification that register_77 property has been written
  RCCResult register_77_written() {
    if (perform_register_written_pre_actions()) {
      set_register(77, m_properties.register_77);
    }
    return RCC_OK;
  }
  // notification that register_77 property will be read
  RCCResult register_77_read() {
    m_properties.register_77 = slave.get_register_77();
    return RCC_OK;
  }
  // notification that register_78 property has been written
  RCCResult register_78_written() {
    if (perform_register_written_pre_actions()) {
      set_register(78, m_properties.register_78);
    }
    return RCC_OK;
  }
  // notification that register_78 property will be read
  RCCResult register_78_read() {
    m_properties.register_78 = slave.get_register_78();
    return RCC_OK;
  }
  // notification that register_79 property has been written
  RCCResult register_79_written() {
    if (perform_register_written_pre_actions()) {
      set_register(79, m_properties.register_79);
    }
    return RCC_OK;
  }
  // notification that register_79 property will be read
  RCCResult register_79_read() {
    m_properties.register_79 = slave.get_register_79();
    return RCC_OK;
  }
  // notification that register_80 property has been written
  RCCResult register_80_written() {
    if (perform_register_written_pre_actions()) {
      set_register(80, m_properties.register_80);
    }
    return RCC_OK;
  }
  // notification that register_80 property will be read
  RCCResult register_80_read() {
    m_properties.register_80 = slave.get_register_80();
    return RCC_OK;
  }
  // notification that register_81 property has been written
  RCCResult register_81_written() {
    if (perform_register_written_pre_actions()) {
      set_register(81, m_properties.register_81);
    }
    return RCC_OK;
  }
  // notification that register_81 property will be read
  RCCResult register_81_read() {
    m_properties.register_81 = slave.get_register_81();
    return RCC_OK;
  }
  // notification that register_82 property has been written
  RCCResult register_82_written() {
    if (perform_register_written_pre_actions()) {
      set_register(82, m_properties.register_82);
    }
    return RCC_OK;
  }
  // notification that register_82 property will be read
  RCCResult register_82_read() {
    m_properties.register_82 = slave.get_register_82();
    return RCC_OK;
  }
  // notification that register_83 property has been written
  RCCResult register_83_written() {
    if (perform_register_written_pre_actions()) {
      set_register(83, m_properties.register_83);
    }
    return RCC_OK;
  }
  // notification that register_83 property will be read
  RCCResult register_83_read() {
    m_properties.register_83 = slave.get_register_83();
    return RCC_OK;
  }
  // notification that register_84 property has been written
  RCCResult register_84_written() {
    if (perform_register_written_pre_actions()) {
      set_register(84, m_properties.register_84);
    }
    return RCC_OK;
  }
  // notification that register_84 property will be read
  RCCResult register_84_read() {
    m_properties.register_84 = slave.get_register_84();
    return RCC_OK;
  }
  // notification that register_85 property has been written
  RCCResult register_85_written() {
    if (perform_register_written_pre_actions()) {
      set_register(85, m_properties.register_85);
    }
    return RCC_OK;
  }
  // notification that register_85 property will be read
  RCCResult register_85_read() {
    m_properties.register_85 = slave.get_register_85();
    return RCC_OK;
  }
  // notification that register_86 property has been written
  RCCResult register_86_written() {
    if (perform_register_written_pre_actions()) {
      set_register(86, m_properties.register_86);
    }
    return RCC_OK;
  }
  // notification that register_86 property will be read
  RCCResult register_86_read() {
    m_properties.register_86 = slave.get_register_86();
    return RCC_OK;
  }
  // notification that register_87 property has been written
  RCCResult register_87_written() {
    if (perform_register_written_pre_actions()) {
      set_register(87, m_properties.register_87);
    }
    return RCC_OK;
  }
  // notification that register_87 property will be read
  RCCResult register_87_read() {
    m_properties.register_87 = slave.get_register_87();
    return RCC_OK;
  }
  // notification that register_88 property has been written
  RCCResult register_88_written() {
    if (perform_register_written_pre_actions()) {
      set_register(88, m_properties.register_88);
    }
    return RCC_OK;
  }
  // notification that register_88 property will be read
  RCCResult register_88_read() {
    m_properties.register_88 = slave.get_register_88();
    return RCC_OK;
  }
  // notification that register_89 property has been written
  RCCResult register_89_written() {
    if (perform_register_written_pre_actions()) {
      set_register(89, m_properties.register_89);
    }
    return RCC_OK;
  }
  // notification that register_89 property will be read
  RCCResult register_89_read() {
    m_properties.register_89 = slave.get_register_89();
    return RCC_OK;
  }
  // notification that register_90 property has been written
  RCCResult register_90_written() {
    if (perform_register_written_pre_actions()) {
      set_register(90, m_properties.register_90);
    }
    return RCC_OK;
  }
  // notification that register_90 property will be read
  RCCResult register_90_read() {
    m_properties.register_90 = slave.get_register_90();
    return RCC_OK;
  }
  // notification that register_91 property has been written
  RCCResult register_91_written() {
    if (perform_register_written_pre_actions()) {
      set_register(91, m_properties.register_91);
    }
    return RCC_OK;
  }
  // notification that register_91 property will be read
  RCCResult register_91_read() {
    m_properties.register_91 = slave.get_register_91();
    return RCC_OK;
  }
  // notification that register_92 property has been written
  RCCResult register_92_written() {
    if (perform_register_written_pre_actions()) {
      set_register(92, m_properties.register_92);
    }
    return RCC_OK;
  }
  // notification that register_92 property will be read
  RCCResult register_92_read() {
    m_properties.register_92 = slave.get_register_92();
    return RCC_OK;
  }
  // notification that register_93 property has been written
  RCCResult register_93_written() {
    if (perform_register_written_pre_actions()) {
      set_register(93, m_properties.register_93);
    }
    return RCC_OK;
  }
  // notification that register_93 property will be read
  RCCResult register_93_read() {
    m_properties.register_93 = slave.get_register_93();
    return RCC_OK;
  }
  // notification that register_94 property has been written
  RCCResult register_94_written() {
    if (perform_register_written_pre_actions()) {
      set_register(94, m_properties.register_94);
    }
    return RCC_OK;
  }
  // notification that register_94 property will be read
  RCCResult register_94_read() {
    m_properties.register_94 = slave.get_register_94();
    return RCC_OK;
  }
  // notification that register_95 property has been written
  RCCResult register_95_written() {
    if (perform_register_written_pre_actions()) {
      set_register(95, m_properties.register_95);
    }
    return RCC_OK;
  }
  // notification that register_95 property will be read
  RCCResult register_95_read() {
    m_properties.register_95 = slave.get_register_95();
    return RCC_OK;
  }
  // notification that register_96 property has been written
  RCCResult register_96_written() {
    if (perform_register_written_pre_actions()) {
      set_register(96, m_properties.register_96);
    }
    return RCC_OK;
  }
  // notification that register_96 property will be read
  RCCResult register_96_read() {
    m_properties.register_96 = slave.get_register_96();
    return RCC_OK;
  }
  // notification that register_97 property has been written
  RCCResult register_97_written() {
    if (perform_register_written_pre_actions()) {
      set_register(97, m_properties.register_97);
    }
    return RCC_OK;
  }
  // notification that register_97 property will be read
  RCCResult register_97_read() {
    m_properties.register_97 = slave.get_register_97();
    return RCC_OK;
  }
  // notification that register_98 property has been written
  RCCResult register_98_written() {
    if (perform_register_written_pre_actions()) {
      set_register(98, m_properties.register_98);
    }
    return RCC_OK;
  }
  // notification that register_98 property will be read
  RCCResult register_98_read() {
    m_properties.register_98 = slave.get_register_98();
    return RCC_OK;
  }
  // notification that register_99 property has been written
  RCCResult register_99_written() {
    if (perform_register_written_pre_actions()) {
      set_register(99, m_properties.register_99);
    }
    return RCC_OK;
  }
  // notification that register_99 property will be read
  RCCResult register_99_read() {
    m_properties.register_99 = slave.get_register_99();
    return RCC_OK;
  }
  // notification that register_100 property has been written
  RCCResult register_100_written() {
    if (perform_register_written_pre_actions()) {
      set_register(100, m_properties.register_100);
    }
    return RCC_OK;
  }
  // notification that register_100 property will be read
  RCCResult register_100_read() {
    m_properties.register_100 = slave.get_register_100();
    return RCC_OK;
  }
  // notification that register_101 property has been written
  RCCResult register_101_written() {
    if (perform_register_written_pre_actions()) {
      set_register(101, m_properties.register_101);
    }
    return RCC_OK;
  }
  // notification that register_101 property will be read
  RCCResult register_101_read() {
    m_properties.register_101 = slave.get_register_101();
    return RCC_OK;
  }
  // notification that register_102 property has been written
  RCCResult register_102_written() {
    if (perform_register_written_pre_actions()) {
      set_register(102, m_properties.register_102);
    }
    return RCC_OK;
  }
  // notification that register_102 property will be read
  RCCResult register_102_read() {
    m_properties.register_102 = slave.get_register_102();
    return RCC_OK;
  }
  // notification that register_103 property has been written
  RCCResult register_103_written() {
    if (perform_register_written_pre_actions()) {
      set_register(103, m_properties.register_103);
    }
    return RCC_OK;
  }
  // notification that register_103 property will be read
  RCCResult register_103_read() {
    m_properties.register_103 = slave.get_register_103();
    return RCC_OK;
  }
  // notification that register_104 property has been written
  RCCResult register_104_written() {
    if (perform_register_written_pre_actions()) {
      set_register(104, m_properties.register_104);
    }
    return RCC_OK;
  }
  // notification that register_104 property will be read
  RCCResult register_104_read() {
    m_properties.register_104 = slave.get_register_104();
    return RCC_OK;
  }
  // notification that register_105 property has been written
  RCCResult register_105_written() {
    if (perform_register_written_pre_actions()) {
      set_register(105, m_properties.register_105);
    }
    return RCC_OK;
  }
  // notification that register_105 property will be read
  RCCResult register_105_read() {
    m_properties.register_105 = slave.get_register_105();
    return RCC_OK;
  }
  // notification that register_106 property has been written
  RCCResult register_106_written() {
    if (perform_register_written_pre_actions()) {
      set_register(106, m_properties.register_106);
    }
    return RCC_OK;
  }
  // notification that register_106 property will be read
  RCCResult register_106_read() {
    m_properties.register_106 = slave.get_register_106();
    return RCC_OK;
  }
  // notification that register_107 property will be read
  RCCResult register_107_read() {
    m_properties.register_107 = slave.get_register_107();
    return RCC_OK;
  }
  // notification that register_108 property will be read
  RCCResult register_108_read() {
    m_properties.register_108 = slave.get_register_108();
    return RCC_OK;
  }
  // notification that register_109 property will be read
  RCCResult register_109_read() {
    m_properties.register_109 = slave.get_register_109();
    return RCC_OK;
  }
  // notification that register_110 property will be read
  RCCResult register_110_read() {
    m_properties.register_110 = slave.get_register_110();
    return RCC_OK;
  }
  // notification that register_111 property will be read
  RCCResult register_111_read() {
    m_properties.register_111 = slave.get_register_111();
    return RCC_OK;
  }
  // notification that register_112 property will be read
  RCCResult register_112_read() {
    m_properties.register_112 = slave.get_register_112();
    return RCC_OK;
  }
};

LMX2594_PROXY_START_INFO
// Insert any static info assignments here (memSize, memSizes, portInfo)
// e.g.: info.memSize = sizeof(MyMemoryStruct);
// YOU MUST LEAVE THE *START_INFO and *END_INFO macros here and uncommented in any case
LMX2594_PROXY_END_INFO
