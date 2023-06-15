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
 * THIS FILE WAS ORIGINALLY GENERATED ON Wed Mar 15 22:57:04 2023 EDT
 * BASED ON THE FILE: drc.xml
 * YOU *ARE* EXPECTED TO EDIT IT
 *
 * This file contains the implementation skeleton for the drc worker in C++
 */

#include "drc-worker.hh"

#include <stdexcept>
#include "metal/io.h" // libmetal opencpi system RFDC_*ADDR definitions
#include "RFDCDRC.hh"

using namespace OCPI::RCC; // for easy access to RCC data types and constants
using namespace DrcWorkerTypes;

#include "OcpiDrcProxyApi.hh" // this must be after the "using namespace" of the types namespace

namespace OD = OCPI::DRC;

// -----------------------------------------------------------------------------
// STEP 1 - DEFINE Constraint Satisfaction Problem (CSP)
// -----------------------------------------------------------------------------

class ZRF8CSP : public RFDCCSP {
  protected:
  void define_x_d_zrf8() {
    m_solver.add_var<int32_t>("zrf8_dir_j20");
    m_solver.add_var<int32_t>("zrf8_dir_j18");
    m_solver.add_var<int32_t>("zrf8_dir_j3");
    m_solver.add_var<int32_t>("zrf8_dir_j13");
    m_solver.add_var<double>("zrf8_fc_meghz_j20", dfp_tol);
    m_solver.add_var<double>("zrf8_fc_meghz_j18", dfp_tol);
    m_solver.add_var<double>("zrf8_fc_meghz_j3", dfp_tol);
    m_solver.add_var<double>("zrf8_fc_meghz_j13", dfp_tol);
    m_solver.add_var<double>("zrf8_bw_meghz_j20", dfp_tol);
    m_solver.add_var<double>("zrf8_bw_meghz_j18", dfp_tol);
    m_solver.add_var<double>("zrf8_bw_meghz_j3", dfp_tol);
    m_solver.add_var<double>("zrf8_bw_meghz_j13", dfp_tol);
    m_solver.add_var<double>("zrf8_fs_megsps_j20", dfp_tol);
    m_solver.add_var<double>("zrf8_fs_megsps_j18", dfp_tol);
    m_solver.add_var<double>("zrf8_fs_megsps_j3", dfp_tol);
    m_solver.add_var<double>("zrf8_fs_megsps_j13", dfp_tol);
    m_solver.add_var<int32_t>("zrf8_samps_comp_j20");
    m_solver.add_var<int32_t>("zrf8_samps_comp_j18");
    m_solver.add_var<int32_t>("zrf8_samps_comp_j3");
    m_solver.add_var<int32_t>("zrf8_samps_comp_j13");
    m_solver.add_var<int32_t>("zrf8_gain_mode_j20");
    m_solver.add_var<int32_t>("zrf8_gain_mode_j18");
    m_solver.add_var<int32_t>("zrf8_gain_mode_j3");
    m_solver.add_var<int32_t>("zrf8_gain_mode_j13");
    m_solver.add_var<double>("zrf8_gain_db_j20", dfp_tol);
    m_solver.add_var<double>("zrf8_gain_db_j18", dfp_tol);
    m_solver.add_var<double>("zrf8_gain_db_j3", dfp_tol);
    m_solver.add_var<double>("zrf8_gain_db_j13", dfp_tol);
  }
  void define_c_zrf8() {
    m_solver.add_constr("zrf8_dir_j20", "=", "rfdc_dir_rx1");
    m_solver.add_constr("zrf8_dir_j18", "=", "rfdc_dir_rx2");
    m_solver.add_constr("zrf8_dir_j3", "=", "rfdc_dir_tx1");
    m_solver.add_constr("zrf8_dir_j13", "=", "rfdc_dir_tx2");
    m_solver.add_constr("zrf8_fc_meghz_j20", "=", "rfdc_fc_meghz_rx1");
    m_solver.add_constr("zrf8_fc_meghz_j18", "=", "rfdc_fc_meghz_rx2");
    m_solver.add_constr("zrf8_fc_meghz_j3", "=", "rfdc_fc_meghz_tx1");
    m_solver.add_constr("zrf8_fc_meghz_j13", "=", "rfdc_fc_meghz_tx2");
    m_solver.add_constr("zrf8_bw_meghz_j20", "=", "rfdc_bw_meghz_rx1");
    m_solver.add_constr("zrf8_bw_meghz_j18", "=", "rfdc_bw_meghz_rx2");
    m_solver.add_constr("zrf8_bw_meghz_j3", "=", "rfdc_bw_meghz_tx1");
    m_solver.add_constr("zrf8_bw_meghz_j13", "=", "rfdc_bw_meghz_tx2");
    m_solver.add_constr("zrf8_fs_megsps_j20", "=", "rfdc_fs_megsps_rx1");
    m_solver.add_constr("zrf8_fs_megsps_j18", "=", "rfdc_fs_megsps_rx2");
    m_solver.add_constr("zrf8_fs_megsps_j3", "=", "rfdc_fs_megsps_tx1");
    m_solver.add_constr("zrf8_fs_megsps_j13", "=", "rfdc_fs_megsps_tx2");
    m_solver.add_constr("zrf8_samps_comp_j20", "=", "rfdc_samps_comp_rx1");
    m_solver.add_constr("zrf8_samps_comp_j18", "=", "rfdc_samps_comp_rx2");
    m_solver.add_constr("zrf8_samps_comp_j3", "=", "rfdc_samps_comp_tx1");
    m_solver.add_constr("zrf8_samps_comp_j13", "=", "rfdc_samps_comp_tx2");
    m_solver.add_constr("zrf8_gain_mode_j20", "=", "rfdc_gain_mode_rx1");
    m_solver.add_constr("zrf8_gain_mode_j18", "=", "rfdc_gain_mode_rx2");
    m_solver.add_constr("zrf8_gain_mode_j3", "=", "rfdc_gain_mode_tx1");
    m_solver.add_constr("zrf8_gain_mode_j13", "=", "rfdc_gain_mode_tx2");
    m_solver.add_constr("zrf8_gain_db_j20", "=", "rfdc_gain_db_rx1");
    m_solver.add_constr("zrf8_gain_db_j18", "=", "rfdc_gain_db_rx2");
    m_solver.add_constr("zrf8_gain_db_j3", "=", "rfdc_gain_db_tx1");
    m_solver.add_constr("zrf8_gain_db_j13", "=", "rfdc_gain_db_tx2");
  }
  public:
  ZRF8CSP() {
    instance_zrf8();
  }
  void instance_zrf8() {
    instance_rfdc();
    define_x_d_zrf8();
    define_c_zrf8();
  }
}; // class ZRF8CSP

// -----------------------------------------------------------------------------
// STEP 2 - DEFINE CONFIGURATOR THAT UTILIZES THE CSP
// -----------------------------------------------------------------------------

class ZRF8Configurator : public Configurator<ZRF8CSP> {
  public:
  ZRF8Configurator() : Configurator<ZRF8CSP>() {
    init_rf_port_j20();
    init_rf_port_j18();
    init_rf_port_j3();
    init_rf_port_j13();
  }
  protected:
  void init_rf_port_j20() {
    // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
    // variables names which are specific to this DRC (a CSP is generic and knows
    // nothing about a DRC, this is what ties the two together)
    CSPVarMap map;
    map.insert(std::make_pair(RFPort::config_t::direction,
        "zrf8_dir_j20"));
    map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
        "zrf8_fc_meghz_j20"));
    map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
        "zrf8_bw_meghz_j20"));
    map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
        "zrf8_fs_megsps_j20"));
    map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
        "zrf8_samps_comp_j20"));
    map.insert(std::make_pair(RFPort::config_t::gain_mode,
        "zrf8_gain_mode_j20"));
    map.insert(std::make_pair(RFPort::config_t::gain_dB,
        "zrf8_gain_db_j20"));
    // make a dictionary entry which ties the mapping to a particular rf_port_name
    m_dict["J20"] = map;
  }
  void init_rf_port_j18() {
    // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
    // variables names which are specific to this DRC (a CSP is generic and knows
    // nothing about a DRC, this is what ties the two together)
    CSPVarMap map;
    map.insert(std::make_pair(RFPort::config_t::direction,
        "zrf8_dir_j18"));
    map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
        "zrf8_fc_meghz_j18"));
    map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
        "zrf8_bw_meghz_j18"));
    map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
        "zrf8_fs_megsps_j18"));
    map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
        "zrf8_samps_comp_j18"));
    map.insert(std::make_pair(RFPort::config_t::gain_mode,
        "zrf8_gain_mode_j18"));
    map.insert(std::make_pair(RFPort::config_t::gain_dB,
        "zrf8_gain_db_j18"));
    // make a dictionary entry which ties the mapping to a particular rf_port_name
    m_dict["J18"] = map;
  }
  void init_rf_port_j3() {
    // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
    // variables names which are specific to this DRC (a CSP is generic and knows
    // nothing about a DRC, this is what ties the two together)
    CSPVarMap map;
    map.insert(std::make_pair(RFPort::config_t::direction,
        "zrf8_dir_j3"));
    map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
        "zrf8_fc_meghz_j3"));
    map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
        "zrf8_bw_meghz_j3"));
    map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
        "zrf8_fs_megsps_j3"));
    map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
        "zrf8_samps_comp_j3"));
    map.insert(std::make_pair(RFPort::config_t::gain_mode,
        "zrf8_gain_mode_j3"));
    map.insert(std::make_pair(RFPort::config_t::gain_dB,
        "zrf8_gain_db_j3"));
    // make a dictionary entry which ties the mapping to a particular rf_port_name
    m_dict["J3"] = map;
  }
  void init_rf_port_j13() {
    // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
    // variables names which are specific to this DRC (a CSP is generic and knows
    // nothing about a DRC, this is what ties the two together)
    CSPVarMap map;
    map.insert(std::make_pair(RFPort::config_t::direction,
        "zrf8_dir_j13"));
    map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
        "zrf8_fc_meghz_j13"));
    map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
        "zrf8_bw_meghz_j13"));
    map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
        "zrf8_fs_megsps_j13"));
    map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
        "zrf8_samps_comp_j13"));
    map.insert(std::make_pair(RFPort::config_t::gain_mode,
        "zrf8_gain_mode_j13"));
    map.insert(std::make_pair(RFPort::config_t::gain_dB,
        "zrf8_gain_db_j13"));
    // make a dictionary entry which ties the mapping to a particular rf_port_name
    m_dict["J13"] = map;
  }
}; // class ZRF8Configurator

// -----------------------------------------------------------------------------
// STEP 3 - DEFINE DRC (get/set APIs)
// -----------------------------------------------------------------------------

/// @brief DEPENDENCIES: lmx2594_proxy.rcc worker
struct LMX2594CallBack {
  virtual void set_register(size_t addr, uint16_t val) = 0;
  virtual void set_in_filename(const std::string& val) = 0;
  virtual void start() = 0;
};

/// @brief DEPENDENCIES: RFDCDRC class (DRC RFDC SUPPORT)
template<class cfgrtr_t = ZRF8Configurator>
class ZRF8DRC : public RFDCDRC<cfgrtr_t> {
  public:
  ZRF8DRC<cfgrtr_t>(DeviceCallBack& dev, LMX2594CallBack& lmx,
      std::string tics_pro_filename = "") :
      RFDCDRC<cfgrtr_t>(dev,
      DRC_RF_PORTS_RX.data[0], DRC_RF_PORTS_RX.data[1],
      DRC_RF_PORTS_TX.data[0], DRC_RF_PORTS_TX.data[1]),
      m_lmx2594_proxy_callback(lmx), m_tics_pro_filename(tics_pro_filename) {
    init();
  }
  void init() {
    init_lmx2594();
    RFDCDRC<cfgrtr_t>::init();
  }
  protected:
  LMX2594CallBack &m_lmx2594_proxy_callback;
  std::string m_tics_pro_filename;
  /// @brief defines how rfdc clock device(s) are initialized on a ZRF8
  void init_clock_source_devices() {
    init_lmx2594();
  }
  /*! @brief This not only sets the LMX 2594 (and, effectively, the ZRF8 RFDC
   *         input) clock rate, but sets a whole slew of other settings - see
   *         TICSPRO-SW or the LMX datasheet for more info. If
   *         set_tics_pro_filename() is already
   *         called with a non-empty value, the config file is used to determine
   *         the clock rate (meant for debugging purposes), otherwise this
   *         sets the rate which the ZRF8 RFDC is currently designed for.
   ****************************************************************************/
  void init_lmx2594() {
    if (m_tics_pro_filename.empty()) {
      m_lmx2594_proxy_callback.set_register(0x70, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6F, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6E, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6D, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6C, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6B, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x6A, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x69, 0x0021);
      m_lmx2594_proxy_callback.set_register(0x68, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x67, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x66, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x65, 0x0011);
      m_lmx2594_proxy_callback.set_register(0x64, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x63, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x62, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x61, 0x0888);
      m_lmx2594_proxy_callback.set_register(0x60, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5F, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5E, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5D, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5C, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5B, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x5A, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x59, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x58, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x57, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x56, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x55, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x54, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x53, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x52, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x51, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x50, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x4F, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x4E, 0x0003);
      m_lmx2594_proxy_callback.set_register(0x4D, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x4C, 0x000C);
      m_lmx2594_proxy_callback.set_register(0x4B, 0x0840);
      m_lmx2594_proxy_callback.set_register(0x4A, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x49, 0x003F);
      m_lmx2594_proxy_callback.set_register(0x48, 0x0001);
      m_lmx2594_proxy_callback.set_register(0x47, 0x0081);
      m_lmx2594_proxy_callback.set_register(0x46, 0xC350);
      m_lmx2594_proxy_callback.set_register(0x45, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x44, 0x03E8);
      m_lmx2594_proxy_callback.set_register(0x43, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x42, 0x01F4);
      m_lmx2594_proxy_callback.set_register(0x41, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x40, 0x1388);
      m_lmx2594_proxy_callback.set_register(0x3F, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x3E, 0x0322);
      m_lmx2594_proxy_callback.set_register(0x3D, 0x00A8);
      m_lmx2594_proxy_callback.set_register(0x3C, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x3B, 0x0001);
      m_lmx2594_proxy_callback.set_register(0x3A, 0x9001);
      m_lmx2594_proxy_callback.set_register(0x39, 0x0020);
      m_lmx2594_proxy_callback.set_register(0x38, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x37, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x36, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x35, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x34, 0x0820);
      m_lmx2594_proxy_callback.set_register(0x33, 0x0080);
      m_lmx2594_proxy_callback.set_register(0x32, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x31, 0x4180);
      m_lmx2594_proxy_callback.set_register(0x30, 0x0300);
      m_lmx2594_proxy_callback.set_register(0x2F, 0x0300);
      m_lmx2594_proxy_callback.set_register(0x2E, 0x07FC);
      m_lmx2594_proxy_callback.set_register(0x2D, 0xC0DF);
      m_lmx2594_proxy_callback.set_register(0x2C, 0x1F22);
      m_lmx2594_proxy_callback.set_register(0x2B, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x2A, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x29, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x28, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x27, 0xFFFF);
      m_lmx2594_proxy_callback.set_register(0x26, 0xFFFF);
      m_lmx2594_proxy_callback.set_register(0x25, 0x0304);
      m_lmx2594_proxy_callback.set_register(0x24, 0x0048);
      m_lmx2594_proxy_callback.set_register(0x23, 0x0004);
      m_lmx2594_proxy_callback.set_register(0x22, 0x0000);
      m_lmx2594_proxy_callback.set_register(0x21, 0x1E21);
      m_lmx2594_proxy_callback.set_register(0x20, 0x0393);
      m_lmx2594_proxy_callback.set_register(0x1F, 0x43EC);
      m_lmx2594_proxy_callback.set_register(0x1E, 0x318C);
      m_lmx2594_proxy_callback.set_register(0x1D, 0x318C);
      m_lmx2594_proxy_callback.set_register(0x1C, 0x0488);
      m_lmx2594_proxy_callback.set_register(0x1B, 0x0002);
      m_lmx2594_proxy_callback.set_register(0x1A, 0x0DB0);
      m_lmx2594_proxy_callback.set_register(0x19, 0x0C2B);
      m_lmx2594_proxy_callback.set_register(0x18, 0x071A);
      m_lmx2594_proxy_callback.set_register(0x17, 0x007C);
      m_lmx2594_proxy_callback.set_register(0x16, 0x0001);
      m_lmx2594_proxy_callback.set_register(0x15, 0x0401);
      m_lmx2594_proxy_callback.set_register(0x14, 0xF848);
      m_lmx2594_proxy_callback.set_register(0x13, 0x27B7);
      m_lmx2594_proxy_callback.set_register(0x12, 0x0064);
      m_lmx2594_proxy_callback.set_register(0x11, 0x012C);
      m_lmx2594_proxy_callback.set_register(0x10, 0x0080);
      m_lmx2594_proxy_callback.set_register(0x0F, 0x064F);
      m_lmx2594_proxy_callback.set_register(0x0E, 0x1E70);
      m_lmx2594_proxy_callback.set_register(0x0D, 0x4000);
      m_lmx2594_proxy_callback.set_register(0x0C, 0x5001);
      m_lmx2594_proxy_callback.set_register(0x0B, 0x0018);
      m_lmx2594_proxy_callback.set_register(0x0A, 0x10D8);
      m_lmx2594_proxy_callback.set_register(0x09, 0x1604);
      m_lmx2594_proxy_callback.set_register(0x08, 0x2000);
      m_lmx2594_proxy_callback.set_register(0x07, 0x40B2);
      m_lmx2594_proxy_callback.set_register(0x06, 0xC802);
      m_lmx2594_proxy_callback.set_register(0x05, 0x00C8);
      m_lmx2594_proxy_callback.set_register(0x04, 0x0C43);
      m_lmx2594_proxy_callback.set_register(0x03, 0x0642);
      m_lmx2594_proxy_callback.set_register(0x02, 0x0500);
      m_lmx2594_proxy_callback.set_register(0x01, 0x0808);
      m_lmx2594_proxy_callback.set_register(0x00, /*0x251C*/ 0x2518);
    }
    else {
      auto& filename = m_tics_pro_filename;
      m_lmx2594_proxy_callback.set_in_filename(filename.c_str());
    }
    m_lmx2594_proxy_callback.start();
  }
}; // class ZRF8DRC

// -----------------------------------------------------------------------------
// STEP 4 - DEFINE DRC Worker
// -----------------------------------------------------------------------------

/*! @brief DEPENDENCIES: ZRF8DRC/ZRF8Configurator/ZRF8CSP (DRC ZRF8 SUPPORT)
 *                       DeviceCallback/LMX2594Callback   (DEVICE ACCESS)
 ******************************************************************************/
class DrcWorker : public OD::DrcProxyBase {
  struct DoSlave : DeviceCallBack {
    Slaves &m_slaves;
    DoSlave(Slaves &slaves) : m_slaves(slaves) {
    }
    void access_prop(uint16_t addr, unsigned long pof, uint8_t* buf, size_t sz,
        bool read) {
      if (pof == RFDC_IP_CTRL_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_DAC0_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_dac_config_0.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_dac_config_0.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_DAC1_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_dac_config_1.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_dac_config_1.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_DAC2_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_dac_config_2.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_dac_config_2.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_DAC3_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_dac_config_3.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_dac_config_3.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_ADC0_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_adc_config_0.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_adc_config_0.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_ADC1_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_adc_config_1.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_adc_config_1.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_ADC2_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_adc_config_2.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_adc_config_2.setRawPropertyBytes(addr, buf, sz);
        }
      }
      else if (pof == RFDC_IP_ADC3_BASE_ADDR) {
        if (read) {
          m_slaves.rfdc_adc_config_3.getRawPropertyBytes(addr, buf, sz);
        }
        else {
          m_slaves.rfdc_adc_config_3.setRawPropertyBytes(addr, buf, sz);
        }
      }
    }
    // of  - address byte "of"fset relative to the rfdc*hdl slave worker
    //       property space
    // pof - address byte "p"roperty "off"set, or the offset of the worker's
    //       first property within the Xilinx RFDC IP address space (this is
    //       simply used to indicate which worker is to be accessed, based on
    //       the already defined segments from io.h)
    uint8_t get_uchar_prop(unsigned long of, unsigned long pof) {
      uint8_t ret;
      access_prop((uint16_t)of, pof, (uint8_t*)(&ret), sizeof(uint8_t), true);
      return ret;
    }
    uint16_t get_ushort_prop(unsigned long of, unsigned long pof) {
      uint16_t ret;
      access_prop((uint16_t)of, pof, (uint8_t*)(&ret), sizeof(uint16_t), true);
      return ret;
    }
    uint32_t get_ulong_prop(unsigned long of, unsigned long pof) {
      uint32_t ret;
      access_prop((uint16_t)of, pof, (uint8_t*)(&ret), sizeof(uint32_t), true);
      return ret;
    }
    uint64_t get_ulonglong_prop(unsigned long of, unsigned long pof) {
      uint64_t ret;
      access_prop((uint16_t)of, pof, (uint8_t*)(&ret), sizeof(uint64_t), true);
      return ret;
    }
    void set_uchar_prop(unsigned long of, unsigned long pof, uint8_t val) {
      access_prop((uint16_t)of, pof, (uint8_t*)(&val), sizeof(uint8_t), false);
    }
    void set_ushort_prop(unsigned long of, unsigned long pof, uint16_t val) {
      access_prop((uint16_t)of, pof, (uint8_t*)(&val), sizeof(uint16_t), false);
    }
    void set_ulong_prop(unsigned long of, unsigned long pof, uint32_t val) {
      access_prop((uint16_t)of, pof, (uint8_t*)(&val), sizeof(uint32_t), false);
    }
    void set_ulonglong_prop(unsigned long of, unsigned long pof, uint64_t val) {
      access_prop((uint16_t)of, pof, (uint8_t*)(&val), sizeof(uint64_t), false);
    }
    void take_rfdc_axi_lite_out_of_reset() {
      m_slaves.rfdc.start();
    }
    void take_rfdc_axi_stream_out_of_reset() {
      m_slaves.rfdc.set_axis_resetn(true);
    }
  } m_doSlave;
  struct DoSlaveLMX : LMX2594CallBack {
    Slaves &m_slaves;
    DoSlaveLMX(Slaves &slaves) : m_slaves(slaves) {
    }
    void set_register(size_t addr, uint16_t val) {
      if (addr == 0) {
        m_slaves.lmx2594_proxy.set_register_0(val);
      }
      else if (addr == 1) {
        m_slaves.lmx2594_proxy.set_register_1(val);
      }
      else if (addr == 2) {
        m_slaves.lmx2594_proxy.set_register_2(val);
      }
      else if (addr == 3) {
        m_slaves.lmx2594_proxy.set_register_3(val);
      }
      else if (addr == 4) {
        m_slaves.lmx2594_proxy.set_register_4(val);
      }
      else if (addr == 5) {
        m_slaves.lmx2594_proxy.set_register_5(val);
      }
      else if (addr == 6) {
        m_slaves.lmx2594_proxy.set_register_6(val);
      }
      else if (addr == 7) {
        m_slaves.lmx2594_proxy.set_register_7(val);
      }
      else if (addr == 8) {
        m_slaves.lmx2594_proxy.set_register_8(val);
      }
      else if (addr == 9) {
        m_slaves.lmx2594_proxy.set_register_9(val);
      }
      else if (addr == 10) {
        m_slaves.lmx2594_proxy.set_register_10(val);
      }
      else if (addr == 11) {
        m_slaves.lmx2594_proxy.set_register_11(val);
      }
      else if (addr == 12) {
        m_slaves.lmx2594_proxy.set_register_12(val);
      }
      else if (addr == 13) {
        m_slaves.lmx2594_proxy.set_register_13(val);
      }
      else if (addr == 14) {
        m_slaves.lmx2594_proxy.set_register_14(val);
      }
      else if (addr == 15) {
        m_slaves.lmx2594_proxy.set_register_15(val);
      }
      else if (addr == 16) {
        m_slaves.lmx2594_proxy.set_register_16(val);
      }
      else if (addr == 17) {
        m_slaves.lmx2594_proxy.set_register_17(val);
      }
      else if (addr == 18) {
        m_slaves.lmx2594_proxy.set_register_18(val);
      }
      else if (addr == 19) {
        m_slaves.lmx2594_proxy.set_register_19(val);
      }
      else if (addr == 20) {
        m_slaves.lmx2594_proxy.set_register_20(val);
      }
      else if (addr == 21) {
        m_slaves.lmx2594_proxy.set_register_21(val);
      }
      else if (addr == 22) {
        m_slaves.lmx2594_proxy.set_register_22(val);
      }
      else if (addr == 23) {
        m_slaves.lmx2594_proxy.set_register_23(val);
      }
      else if (addr == 24) {
        m_slaves.lmx2594_proxy.set_register_24(val);
      }
      else if (addr == 25) {
        m_slaves.lmx2594_proxy.set_register_25(val);
      }
      else if (addr == 26) {
        m_slaves.lmx2594_proxy.set_register_26(val);
      }
      else if (addr == 27) {
        m_slaves.lmx2594_proxy.set_register_27(val);
      }
      else if (addr == 28) {
        m_slaves.lmx2594_proxy.set_register_28(val);
      }
      else if (addr == 29) {
        m_slaves.lmx2594_proxy.set_register_29(val);
      }
      else if (addr == 30) {
        m_slaves.lmx2594_proxy.set_register_30(val);
      }
      else if (addr == 31) {
        m_slaves.lmx2594_proxy.set_register_31(val);
      }
      else if (addr == 32) {
        m_slaves.lmx2594_proxy.set_register_32(val);
      }
      else if (addr == 33) {
        m_slaves.lmx2594_proxy.set_register_33(val);
      }
      else if (addr == 34) {
        m_slaves.lmx2594_proxy.set_register_34(val);
      }
      else if (addr == 35) {
        m_slaves.lmx2594_proxy.set_register_35(val);
      }
      else if (addr == 36) {
        m_slaves.lmx2594_proxy.set_register_36(val);
      }
      else if (addr == 37) {
        m_slaves.lmx2594_proxy.set_register_37(val);
      }
      else if (addr == 38) {
        m_slaves.lmx2594_proxy.set_register_38(val);
      }
      else if (addr == 39) {
        m_slaves.lmx2594_proxy.set_register_39(val);
      }
      else if (addr == 40) {
        m_slaves.lmx2594_proxy.set_register_40(val);
      }
      else if (addr == 41) {
        m_slaves.lmx2594_proxy.set_register_41(val);
      }
      else if (addr == 42) {
        m_slaves.lmx2594_proxy.set_register_42(val);
      }
      else if (addr == 43) {
        m_slaves.lmx2594_proxy.set_register_43(val);
      }
      else if (addr == 44) {
        m_slaves.lmx2594_proxy.set_register_44(val);
      }
      else if (addr == 45) {
        m_slaves.lmx2594_proxy.set_register_45(val);
      }
      else if (addr == 46) {
        m_slaves.lmx2594_proxy.set_register_46(val);
      }
      else if (addr == 47) {
        m_slaves.lmx2594_proxy.set_register_47(val);
      }
      else if (addr == 48) {
        m_slaves.lmx2594_proxy.set_register_48(val);
      }
      else if (addr == 49) {
        m_slaves.lmx2594_proxy.set_register_49(val);
      }
      else if (addr == 50) {
        m_slaves.lmx2594_proxy.set_register_50(val);
      }
      else if (addr == 51) {
        m_slaves.lmx2594_proxy.set_register_51(val);
      }
      else if (addr == 52) {
        m_slaves.lmx2594_proxy.set_register_52(val);
      }
      else if (addr == 53) {
        m_slaves.lmx2594_proxy.set_register_53(val);
      }
      else if (addr == 54) {
        m_slaves.lmx2594_proxy.set_register_54(val);
      }
      else if (addr == 55) {
        m_slaves.lmx2594_proxy.set_register_55(val);
      }
      else if (addr == 56) {
        m_slaves.lmx2594_proxy.set_register_56(val);
      }
      else if (addr == 57) {
        m_slaves.lmx2594_proxy.set_register_57(val);
      }
      else if (addr == 58) {
        m_slaves.lmx2594_proxy.set_register_58(val);
      }
      else if (addr == 59) {
        m_slaves.lmx2594_proxy.set_register_59(val);
      }
      else if (addr == 60) {
        m_slaves.lmx2594_proxy.set_register_60(val);
      }
      else if (addr == 61) {
        m_slaves.lmx2594_proxy.set_register_61(val);
      }
      else if (addr == 62) {
        m_slaves.lmx2594_proxy.set_register_62(val);
      }
      else if (addr == 63) {
        m_slaves.lmx2594_proxy.set_register_63(val);
      }
      else if (addr == 64) {
        m_slaves.lmx2594_proxy.set_register_64(val);
      }
      else if (addr == 65) {
        m_slaves.lmx2594_proxy.set_register_65(val);
      }
      else if (addr == 66) {
        m_slaves.lmx2594_proxy.set_register_66(val);
      }
      else if (addr == 67) {
        m_slaves.lmx2594_proxy.set_register_67(val);
      }
      else if (addr == 68) {
        m_slaves.lmx2594_proxy.set_register_68(val);
      }
      else if (addr == 69) {
        m_slaves.lmx2594_proxy.set_register_69(val);
      }
      else if (addr == 70) {
        m_slaves.lmx2594_proxy.set_register_70(val);
      }
      else if (addr == 71) {
        m_slaves.lmx2594_proxy.set_register_71(val);
      }
      else if (addr == 72) {
        m_slaves.lmx2594_proxy.set_register_72(val);
      }
      else if (addr == 73) {
        m_slaves.lmx2594_proxy.set_register_73(val);
      }
      else if (addr == 74) {
        m_slaves.lmx2594_proxy.set_register_74(val);
      }
      else if (addr == 75) {
        m_slaves.lmx2594_proxy.set_register_75(val);
      }
      else if (addr == 76) {
        m_slaves.lmx2594_proxy.set_register_76(val);
      }
      else if (addr == 77) {
        m_slaves.lmx2594_proxy.set_register_77(val);
      }
      else if (addr == 78) {
        m_slaves.lmx2594_proxy.set_register_78(val);
      }
      else if (addr == 79) {
        m_slaves.lmx2594_proxy.set_register_79(val);
      }
      else if (addr == 80) {
        m_slaves.lmx2594_proxy.set_register_80(val);
      }
      else if (addr == 81) {
        m_slaves.lmx2594_proxy.set_register_81(val);
      }
      else if (addr == 82) {
        m_slaves.lmx2594_proxy.set_register_82(val);
      }
      else if (addr == 83) {
        m_slaves.lmx2594_proxy.set_register_83(val);
      }
      else if (addr == 84) {
        m_slaves.lmx2594_proxy.set_register_84(val);
      }
      else if (addr == 85) {
        m_slaves.lmx2594_proxy.set_register_85(val);
      }
      else if (addr == 86) {
        m_slaves.lmx2594_proxy.set_register_86(val);
      }
      else if (addr == 87) {
        m_slaves.lmx2594_proxy.set_register_87(val);
      }
      else if (addr == 88) {
        m_slaves.lmx2594_proxy.set_register_88(val);
      }
      else if (addr == 89) {
        m_slaves.lmx2594_proxy.set_register_89(val);
      }
      else if (addr == 90) {
        m_slaves.lmx2594_proxy.set_register_90(val);
      }
      else if (addr == 91) {
        m_slaves.lmx2594_proxy.set_register_91(val);
      }
      else if (addr == 92) {
        m_slaves.lmx2594_proxy.set_register_92(val);
      }
      else if (addr == 93) {
        m_slaves.lmx2594_proxy.set_register_93(val);
      }
      else if (addr == 94) {
        m_slaves.lmx2594_proxy.set_register_94(val);
      }
      else if (addr == 95) {
        m_slaves.lmx2594_proxy.set_register_95(val);
      }
      else if (addr == 96) {
        m_slaves.lmx2594_proxy.set_register_96(val);
      }
      else if (addr == 97) {
        m_slaves.lmx2594_proxy.set_register_97(val);
      }
      else if (addr == 98) {
        m_slaves.lmx2594_proxy.set_register_98(val);
      }
      else if (addr == 99) {
        m_slaves.lmx2594_proxy.set_register_99(val);
      }
      else if (addr == 100) {
        m_slaves.lmx2594_proxy.set_register_100(val);
      }
      else if (addr == 101) {
        m_slaves.lmx2594_proxy.set_register_101(val);
      }
      else if (addr == 102) {
        m_slaves.lmx2594_proxy.set_register_102(val);
      }
      else if (addr == 103) {
        m_slaves.lmx2594_proxy.set_register_103(val);
      }
      else if (addr == 104) {
        m_slaves.lmx2594_proxy.set_register_104(val);
      }
      else if (addr == 105) {
        m_slaves.lmx2594_proxy.set_register_105(val);
      }
      else if (addr == 106) {
        m_slaves.lmx2594_proxy.set_register_106(val);
      }
    }
    void set_in_filename(const std::string& val) {
      m_slaves.lmx2594_proxy.set_in_filename(val.c_str());
    }
    void start() {
      m_slaves.lmx2594_proxy.start();
    }
  } m_doSlave_lmx;
  ZRF8DRC<ZRF8Configurator>* m_p_ctrlr;
public:
  DrcWorker() : m_doSlave(slaves), m_doSlave_lmx(slaves), m_p_ctrlr(0) {
  }
  ~DrcWorker() {
    delete m_p_ctrlr;
  }
  RCCResult start() {
    RCCResult ret = RCC_OK;
    log(8, "STARTING DRC PROXY");
    if (!m_p_ctrlr) {
      try {
        m_p_ctrlr = new ZRF8DRC<ZRF8Configurator>(m_doSlave, m_doSlave_lmx);
      } catch(std::exception& err) {
        log(8, "%s", err.what());
        ret = RCC_ERROR;
      }
    }
    if (ret == RCC_OK) {
      size_t nConfigs = m_properties.configurations.size();
      RCCResult rc;
      for (size_t n = 0; n < nConfigs; ++n)
        if (m_started[n]) {
          m_started[n] = false;
          if ((rc = DrcProxyBase::start_config(n, true)))
            return rc;
        }
    }
    return ret;
  }
  RCCResult prepare_config(unsigned config) {
    typedef RFPort::direction_t direction_t;
    auto &conf = m_properties.configurations.data[config];
    ConfigLockRequest req;
    auto nChannels = conf.channels.length;
    for (unsigned n = 0; n < nChannels; ++n) {
      auto &channel = conf.channels.data[n];
      direction_t direction = channel.rx ? direction_t::rx : direction_t::tx;
      RFPortConfigLockRequest rf_port(
          direction,
          channel.tuning_freq_MHz,
          channel.bandwidth_3dB_MHz,
          channel.sampling_rate_Msps,
          channel.samples_are_complex,
          channel.gain_mode,
          channel.gain_dB,
          channel.tolerance_tuning_freq_MHz,
          channel.tolerance_bandwidth_3dB_MHz,
          channel.tolerance_sampling_rate_Msps,
          channel.tolerance_gain_dB,
          channel.rf_port_name,
          channel.rf_port_num,
          channel.app_port_num);
      req.push_back(rf_port);
    }
    RCCResult rc = RCC_OK;
    try {
      m_p_ctrlr->set_configuration((uint16_t)config, req);
      if (!m_p_ctrlr->prepare((uint16_t)config))
        throw std::runtime_error("failed");
    } catch(std::exception& err) {
      std::string ctrlerr = m_p_ctrlr->get_error().c_str();
      log(8, "ERROR: %s", ctrlerr.c_str());
      log(8, "ERROR: %s", err.what());
      if(conf.recoverable) {
        size_t count = ctrlerr.size();
        count = std::min(count, (size_t)DRC_MAX_STRING_LENGTH_P);
        memcpy(&m_properties.status.data[config].error, ctrlerr.c_str(), count);
        rc = RCC_OK;
      }
      else {
        rc = setError("config prepare request was unsuccessful, set OCPI_LOG_LEVEL to 8 "
                 "(or higher) for more info");
      }
    }
    return rc;
  }
  RCCResult start_config(unsigned config) {
    try {
      return m_p_ctrlr->start((uint16_t)config) ? RCC_OK :
        setError("config start was unsuccessful, set OCPI_LOG_LEVEL to 8 "
                 "(or higher) for more info");
    } catch(std::exception& err) {
      return setError(err.what());
    }
    return RCC_OK;
  }
  /// @todo / FIXME consolidate into OcpiDrcProxyApi.hh
  RCCResult stop_config(unsigned config) { 
    log(8, "DRC: stop_config: %u", config);
    try {
      return m_p_ctrlr->stop((uint16_t)config) ? RCC_OK :
        setError("config stop was unsuccessful, set OCPI_LOG_LEVEL to 8 "
                 "(or higher) for more info");
    } catch(std::exception& err) {
      return setError(err.what());
    }
    return RCC_OK;
  }
  // notification that status property will be read
  RCCResult status_read() {
    size_t nConfigs = m_properties.configurations.size();
    m_properties.status.resize(nConfigs);
    for (size_t n = 0; n < nConfigs; ++n) {
      auto &conf = m_properties.configurations.data[n];
      auto &stat = m_properties.status.data[n];
      /// @todo / FIXME add below line in OcpiDrcProxyApi.hh
      stat.channels.resize(conf.channels.size());
      // stat.state member is already maintained
      // stat.error
      for (size_t nch = 0; nch < conf.channels.size(); ++nch) {
	auto &confchan = conf.channels.data[nch];
	auto &statchan = stat.channels.data[nch];
	statchan.tuning_freq_MHz = confchan.tuning_freq_MHz;
	statchan.bandwidth_3dB_MHz = confchan.bandwidth_3dB_MHz;
	statchan.sampling_rate_Msps = confchan.sampling_rate_Msps;
	statchan.gain_dB = confchan.gain_dB;
      }
      status_config(n);
    }
    return RCC_OK;
  }
  RCCResult release_config(unsigned config) {
    log(8, "DRC: release_config");
    return m_p_ctrlr->release((uint16_t)config) ? RCC_OK :
      setError("config release was unsuccessful, set OCPI_LOG_LEVEL to 8 "
               "(or higher) for more info");
  }
  // notification that tics_pro_filename property has been written
  RCCResult tics_pro_filename_written() {
    RCCResult ret = RCC_OK;
    auto& fname = m_properties.tics_pro_filename;
    if (!std::string(fname).empty()) {
      try {
        m_p_ctrlr = new ZRF8DRC<ZRF8Configurator>(m_doSlave, m_doSlave_lmx, fname);
      } catch(std::exception& err) {
        log(8, "%s", err.what());
        ret = RCC_ERROR;
      }
    }
    return ret;
  }
  // notification that dump_regs property has been written
  RCCResult dump_regs_written() {
    if (properties().dump_regs) {
      m_p_ctrlr->dump_regs();
    }
    return RCC_OK;
  }
};

DRC_START_INFO
// Insert any static info assignments here (memSize, memSizes, portInfo)
// e.g.: info.memSize = sizeof(MyMemoryStruct);
// YOU MUST LEAVE THE *START_INFO and *END_INFO macros here and uncommented in any case
DRC_END_INFO
