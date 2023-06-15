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

#ifndef _RFDC_DRC_HH
#define _RFDC_DRC_HH

#include "DRC.hh"
#include "xrfdc.h"

// -----------------------------------------------------------------------------
// STEP 1 - DEFINE Constraint Satisfaction Problem (CSP)
// -----------------------------------------------------------------------------

class RFDCCSP : public CSPBase {
  protected:
  void define_x_d_rfdc();
  void define_c_rfdc();
  public:
  RFDCCSP();
  void instance_rfdc();
};

// -----------------------------------------------------------------------------
// STEP 2 - DEFINE CONFIGURATOR THAT UTILIZES THE CSP
// -----------------------------------------------------------------------------

class RFDCConfigurator : public Configurator<RFDCCSP> {
  public:
  RFDCConfigurator();
  protected:
  void init_rf_port_rx1();
  void init_rf_port_rx2();
  void init_rf_port_tx1();
  void init_rf_port_tx2();
};

// -----------------------------------------------------------------------------
// STEP 3 - DEFINE DRC (get/set APIs)
// -----------------------------------------------------------------------------

struct rfdc_ip_version_t {
  int major;
  int minor;
};

struct rfdc_api_info_for_drc_rf_port {
  u32              type;
  u32              tile;
  std::vector<u32> blocks;
};

/*! @brief DEPENDENCIES: rfdc.hdl worker,
 *                       rfdc_dac_0.hdl worker,
 *                       rfdc_dac_1.hdl worker,
 *                       rfdc_dac_2.hdl worker,
 *                       rfdc_dac_3.hdl worker,
 *                       rfdc_adc_0.hdl worker,
 *                       rfdc_adc_1.hdl worker,
 *                       rfdc_adc_2.hdl worker,
 *                       rfdc_adc_3.hdl worker
 ******************************************************************************/
struct DeviceCallBack {
  // from the low level rfdc/libmetal library
  virtual uint8_t get_uchar_prop(unsigned long of, unsigned long pof) = 0;
  virtual uint16_t get_ushort_prop(unsigned long of, unsigned long pof) = 0;
  virtual uint32_t get_ulong_prop(unsigned long of, unsigned long pof) = 0;
  virtual uint64_t get_ulonglong_prop(unsigned long of, unsigned long pof) = 0;
  virtual void set_uchar_prop(unsigned long of, unsigned long pof,
      uint8_t val) = 0;
  virtual void set_ushort_prop(unsigned long of, unsigned long pof,
      uint16_t val) = 0;
  virtual void set_ulong_prop(unsigned long of, unsigned long pof,
      uint32_t val) = 0;
  virtual void set_ulonglong_prop(unsigned long of, unsigned long pof,
      uint64_t val) = 0;
  virtual void take_rfdc_axi_lite_out_of_reset() = 0;
  virtual void take_rfdc_axi_stream_out_of_reset() = 0;
};

/*! @brief This class represents a Xilinx RF Data Converter (RFDC) with the
 *         generic DRC API. The rfdc software library is a dependency, with its
 *         in-tree libmetal library's linux system assumed patched to use
 *         struct DeviceCallBacks for its io accesses (this is because we are
 *         forcing the use of OpenCPI control plane for io).
 *         DEPENDENCIES: DRC/Configurator/CSP classes   (DRC BASE SERVICES)
 *                       rfdc OCPI prerequisite library (RFDC/LIBMETAL LIBRARY)
 ******************************************************************************/
template<class cfgrtr_t = RFDCConfigurator>
class RFDCDRC : public DRC<cfgrtr_t> {
  public:
  RFDCDRC(DeviceCallBack &dev,
      const std::string& rf_port_name_rx1 = "rx1",
      const std::string& rf_port_name_rx2 = "rx2",
      const std::string& rf_port_name_tx1 = "tx1",
      const std::string& rf_port_name_tx2 = "tx2");
  bool                get_enabled(            const std::string& rf_port_name);
  RFPort::direction_t get_direction(          const std::string& rf_port_name);
  double              get_tuning_freq_MHz(    const std::string& rf_port_name);
  double              get_bandwidth_3dB_MHz(  const std::string& rf_port_name);
  double              get_sampling_rate_Msps( const std::string& rf_port_name);
  bool                get_samples_are_complex(const std::string& rf_port_name);
  std::string         get_gain_mode(          const std::string& rf_port_name);
  double              get_gain_dB(            const std::string& rf_port_name);
  uint8_t             get_app_port_num(       const std::string& rf_port_name);
  void set_direction(const std::string& rf_port_name, RFPort::direction_t val);
  void set_tuning_freq_MHz(    const std::string& rf_port_name, double val);
  void set_bandwidth_3dB_MHz(  const std::string& rf_port_name, double val);
  void set_sampling_rate_Msps( const std::string& rf_port_name, double val);
  void set_samples_are_complex(const std::string& rf_port_name, bool val);
  void set_gain_mode(          const std::string& rf_port_name, const std::string& val);
  void set_gain_dB(            const std::string& rf_port_name, double val);
  void set_app_port_num(       const std::string& rf_port_name, uint8_t val);
  void set_resampling_rate(    const std::string& rf_port_name, u32 val);
  void dump_regs();
  //virtual bool prepare(unsigned config);
  //virtual bool release(unsigned config);
  protected:
  std::map<std::string, rfdc_api_info_for_drc_rf_port> m_rf_port_infos;
  XRFdc m_xrfdc;
  DeviceCallBack &m_callback;
  rfdc_ip_version_t get_fpga_rfdc_ip_version();
  void throw_if_rf_port_name_invalid(const std::string& rf_port_name);
  void throw_if_proof_of_life_reg_test_fails();
  void         init_rf_port_infos(
      const std::string& rf_port_name_rx1,
      const std::string& rf_port_name_rx2,
      const std::string& rf_port_name_tx1,
      const std::string& rf_port_name_tx2);
  /// @brief important - derived classes must know how to initialize rfdc tile clock(s)
  virtual void init_clock_source_devices() = 0;
  void         init_metal();
  void         init_xrfdc_config();
  void         init();
  void log_xrfdc_status();
}; // class RFDCDRC

#include "RFDCDRC.cc"

#endif // _RFDC_DRC_HH
