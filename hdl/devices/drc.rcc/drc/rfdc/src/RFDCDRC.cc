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

#include "RFDCDRC.hh"
#include <stdexcept>
#include <cinttypes>
#include "xrfdc.h"

#define API_LOG_ONLY(func) \
  this->log_info("rfdc %s", #func);

#define API_NO_RET(func, ...) \
  API_LOG_ONLY(func) \
  func(__VA_ARGS__);

#define API(func, ...) \
  API_LOG_ONLY(func) \
  if (func(__VA_ARGS__) != XRFDC_SUCCESS) { \
    throw std::runtime_error(std::string(#func)+" failure"); \
  }

// -----------------------------------------------------------------------------
// STEP 1 - DEFINE Constraint Satisfaction Problem (CSP)
// -----------------------------------------------------------------------------

void
RFDCCSP::define_x_d_rfdc() {
  m_solver.add_var<int32_t>("rfdc_dir_rx1");
  m_solver.add_var<int32_t>("rfdc_dir_rx2");
  m_solver.add_var<int32_t>("rfdc_dir_tx1");
  m_solver.add_var<int32_t>("rfdc_dir_tx2");
  m_solver.add_var<double>("rfdc_fc_meghz_rx1", dfp_tol);
  m_solver.add_var<double>("rfdc_fc_meghz_rx2", dfp_tol);
  m_solver.add_var<double>("rfdc_fc_meghz_tx1", dfp_tol);
  m_solver.add_var<double>("rfdc_fc_meghz_tx2", dfp_tol);
  m_solver.add_var<double>("rfdc_bw_meghz_rx1", dfp_tol);
  m_solver.add_var<double>("rfdc_bw_meghz_rx2", dfp_tol);
  m_solver.add_var<double>("rfdc_bw_meghz_tx1", dfp_tol);
  m_solver.add_var<double>("rfdc_bw_meghz_tx2", dfp_tol);
  m_solver.add_var<double>("rfdc_fs_megsps_rx1", dfp_tol);
  m_solver.add_var<double>("rfdc_fs_megsps_rx2", dfp_tol);
  m_solver.add_var<double>("rfdc_fs_megsps_tx1", dfp_tol);
  m_solver.add_var<double>("rfdc_fs_megsps_tx2", dfp_tol);
  m_solver.add_var<int32_t>("rfdc_samps_comp_rx1");
  m_solver.add_var<int32_t>("rfdc_samps_comp_rx2");
  m_solver.add_var<int32_t>("rfdc_samps_comp_tx1");
  m_solver.add_var<int32_t>("rfdc_samps_comp_tx2");
  m_solver.add_var<int32_t>("rfdc_gain_mode_rx1");
  m_solver.add_var<int32_t>("rfdc_gain_mode_rx2");
  m_solver.add_var<int32_t>("rfdc_gain_mode_tx1");
  m_solver.add_var<int32_t>("rfdc_gain_mode_tx2");
  m_solver.add_var<double>("rfdc_gain_db_rx1", dfp_tol);
  m_solver.add_var<double>("rfdc_gain_db_rx2", dfp_tol);
  m_solver.add_var<double>("rfdc_gain_db_tx1", dfp_tol);
  m_solver.add_var<double>("rfdc_gain_db_tx2", dfp_tol);
}

void
RFDCCSP::define_c_rfdc() {
  m_solver.add_constr("rfdc_dir_rx1", "=", (int32_t)RFPort::direction_t::rx);
  m_solver.add_constr("rfdc_dir_rx2", "=", (int32_t)RFPort::direction_t::rx);
  m_solver.add_constr("rfdc_dir_tx1", "=", (int32_t)RFPort::direction_t::tx);
  m_solver.add_constr("rfdc_dir_tx2", "=", (int32_t)RFPort::direction_t::tx);
  m_solver.add_constr("rfdc_fc_meghz_rx1", "=", 390.95);
  m_solver.add_constr("rfdc_fc_meghz_rx2", "=", 390.95);
  m_solver.add_constr("rfdc_fc_meghz_tx1", "=", 20.);
  m_solver.add_constr("rfdc_fc_meghz_tx2", "=", 390.95);
  m_solver.add_constr("rfdc_bw_meghz_rx1", "=", 90.);
  m_solver.add_constr("rfdc_bw_meghz_rx2", "=", 90.);
  m_solver.add_constr("rfdc_bw_meghz_tx1", "=", 90.);
  m_solver.add_constr("rfdc_bw_meghz_tx2", "=", 90.);
  m_solver.add_constr("rfdc_fs_megsps_rx1", "=", 90.);
  m_solver.add_constr("rfdc_fs_megsps_rx2", "=", 90.);
  m_solver.add_constr("rfdc_fs_megsps_tx1", "=", 90.);
  m_solver.add_constr("rfdc_fs_megsps_tx2", "=", 90.);
  m_solver.add_constr("rfdc_samps_comp_rx1", "=", (int32_t)1);
  m_solver.add_constr("rfdc_samps_comp_rx2", "=", (int32_t)1);
  m_solver.add_constr("rfdc_samps_comp_tx1", "=", (int32_t)1);
  m_solver.add_constr("rfdc_samps_comp_tx2", "=", (int32_t)1);
  m_solver.add_constr("rfdc_gain_mode_rx1", "=", (int32_t)1); // manual
  m_solver.add_constr("rfdc_gain_mode_rx2", "=", (int32_t)1); // manual
  m_solver.add_constr("rfdc_gain_mode_tx1", "=", (int32_t)1); // manual
  m_solver.add_constr("rfdc_gain_mode_tx2", "=", (int32_t)1); // manual
  m_solver.add_constr("rfdc_gain_db_rx1", "=", 0.);
  m_solver.add_constr("rfdc_gain_db_rx2", "=", 0.);
  m_solver.add_constr("rfdc_gain_db_tx1", "=", 0);
  m_solver.add_constr("rfdc_gain_db_tx2", "=", 0.);
}

RFDCCSP::RFDCCSP() : CSPBase() {
  instance_rfdc();
}

void
RFDCCSP::instance_rfdc() {
  define_x_d_rfdc();
  define_c_rfdc();
}

// -----------------------------------------------------------------------------
// STEP 2 - DEFINE CONFIGURATOR THAT UTILIZES THE CSP
// -----------------------------------------------------------------------------

RFDCConfigurator::RFDCConfigurator() : Configurator<RFDCCSP>() {
  init_rf_port_rx1();
  init_rf_port_rx2();
  init_rf_port_tx1();
  init_rf_port_tx2();
}

void
RFDCConfigurator::init_rf_port_rx1() {
  // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
  // variables names which are specific to this DRC (a CSP is generic and knows
  // nothing about a DRC, this is what ties the two together)
  CSPVarMap map;
  map.insert(std::make_pair(RFPort::config_t::direction,
      "rfdc_dir_rx1"));
  map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
      "rfdc_fc_meghz_rx1"));
  map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
      "rfdc_bw_meghz_rx1"));
  map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
      "rfdc_fs_megsps_rx1"));
  map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
      "rfdc_samps_comp_rx1"));
  map.insert(std::make_pair(RFPort::config_t::gain_mode,
      "rfdc_gain_mode_rx1"));
  map.insert(std::make_pair(RFPort::config_t::gain_dB,
      "rfdc_gain_db_rx1"));
  // make a dictionary entry which ties the mapping to a particular rf_port_name
  m_dict["rx1"] = map;
}

void
RFDCConfigurator::init_rf_port_rx2() {
  // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
  // variables names which are specific to this DRC (a CSP is generic and knows
  // nothing about a DRC, this is what ties the two together)
  CSPVarMap map;
  map.insert(std::make_pair(RFPort::config_t::direction,
      "rfdc_dir_rx2"));
  map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
      "rfdc_fc_meghz_rx2"));
  map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
      "rfdc_bw_meghz_rx2"));
  map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
      "rfdc_fs_megsps_rx2"));
  map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
      "rfdc_samps_comp_rx2"));
  map.insert(std::make_pair(RFPort::config_t::gain_mode,
      "rfdc_gain_mode_rx2"));
  map.insert(std::make_pair(RFPort::config_t::gain_dB,
      "rfdc_gain_db_rx2"));
  // make a dictionary entry which ties the mapping to a particular rf_port_name
  m_dict["rx2"] = map;
}

void
RFDCConfigurator::init_rf_port_tx1() {
  // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
  // variables names which are specific to this DRC (a CSP is generic and knows
  // nothing about a DRC, this is what ties the two together)
  CSPVarMap map;
  map.insert(std::make_pair(RFPort::config_t::direction,
      "rfdc_dir_tx1"));
  map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
      "rfdc_fc_meghz_tx1"));
  map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
      "rfdc_bw_meghz_tx1"));
  map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
      "rfdc_fs_megsps_tx1"));
  map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
      "rfdc_samps_comp_tx1"));
  map.insert(std::make_pair(RFPort::config_t::gain_mode,
      "rfdc_gain_mode_tx1"));
  map.insert(std::make_pair(RFPort::config_t::gain_dB,
      "rfdc_gain_db_tx1"));
  // make a dictionary entry which ties the mapping to a particular rf_port_name
  m_dict["tx1"] = map;
}

void
RFDCConfigurator::init_rf_port_tx2() {
  // maps each of the DRC-specific RFPort::config_t types to their corresponding CSP
  // variables names which are specific to this DRC (a CSP is generic and knows
  // nothing about a DRC, this is what ties the two together)
  CSPVarMap map;
  map.insert(std::make_pair(RFPort::config_t::direction,
      "rfdc_dir_tx2"));
  map.insert(std::make_pair(RFPort::config_t::tuning_freq_MHz,
      "rfdc_fc_meghz_tx2"));
  map.insert(std::make_pair(RFPort::config_t::bandwidth_3dB_MHz,
      "rfdc_bw_meghz_tx2"));
  map.insert(std::make_pair(RFPort::config_t::sampling_rate_Msps,
      "rfdc_fs_megsps_tx2"));
  map.insert(std::make_pair(RFPort::config_t::samples_are_complex,
      "rfdc_samps_comp_tx2"));
  map.insert(std::make_pair(RFPort::config_t::gain_mode,
      "rfdc_gain_mode_tx2"));
  map.insert(std::make_pair(RFPort::config_t::gain_dB,
      "rfdc_gain_db_tx2"));
  // make a dictionary entry which ties the mapping to a particular rf_port_name
  m_dict["tx2"] = map;
}

// -----------------------------------------------------------------------------
// STEP 3 - DEFINE DRC (get/set APIs)
// -----------------------------------------------------------------------------

static DeviceCallBack* g_p_device_callback;

uint8_t get_uchar_prop(unsigned long offset,
    unsigned long prop_off) {
  return g_p_device_callback->get_uchar_prop(offset, prop_off);
}

uint16_t get_ushort_prop(unsigned long offset,
    unsigned long prop_off) {
  return g_p_device_callback->get_ushort_prop(offset, prop_off);
}

uint32_t get_ulong_prop(unsigned long offset,
    unsigned long prop_off) {
  return g_p_device_callback->get_ulong_prop(offset, prop_off);
}

uint64_t get_ulonglong_prop(unsigned long offset,
    unsigned long prop_off) {
  return g_p_device_callback->get_ulonglong_prop(offset, prop_off);
}

void set_uchar_prop(unsigned long offset, unsigned long prop_off, uint8_t val) {
  g_p_device_callback->set_uchar_prop(offset, prop_off, val);
}

void set_ushort_prop(unsigned long offset, unsigned long prop_off, uint16_t val) {
  g_p_device_callback->set_ushort_prop(offset, prop_off, val);
}

void set_ulong_prop(unsigned long offset, unsigned long prop_off, uint32_t val) {
  g_p_device_callback->set_ulong_prop(offset, prop_off, val);
}

void set_ulonglong_prop(unsigned long offset, unsigned long prop_off, uint64_t val) {
  g_p_device_callback->set_ulonglong_prop(offset, prop_off, val);
}

template<class cfgrtr_t>
RFDCDRC<cfgrtr_t>::RFDCDRC(DeviceCallBack &dev,
    const std::string& rf_port_name_rx1,
    const std::string& rf_port_name_rx2,
    const std::string& rf_port_name_tx1,
    const std::string& rf_port_name_tx2) : m_callback(dev) {
  // must "connect" this object's callback (reg interface) to the global
  // pointer before init()
  g_p_device_callback = &m_callback;
  auto& tx1 = rf_port_name_tx1;
  auto& tx2 = rf_port_name_tx2;
  init_rf_port_infos(rf_port_name_rx1, rf_port_name_rx2, tx1, tx2);
  //init();
}

template<class cfgrtr_t> bool
RFDCDRC<cfgrtr_t>::get_enabled(const std::string& rf_port_name) {
  bool ret = true;
  throw_if_rf_port_name_invalid(rf_port_name);
  u32 ty = m_rf_port_infos[rf_port_name].type;
  u32 tl = m_rf_port_infos[rf_port_name].tile;
#if 0
  XRFdc_IPStatus st;
  memset(&st, 0, sizeof(st));
  API(XRFdc_GetIPStatus, &m_xrfdc, &st)
  if (ty == XRFDC_ADC_TILE) {
    ret = st.ADCTileStatus[tl].IsEnabled;
  }
  else {
    ret = st.DACTileStatus[tl].IsEnabled;
  }
#else
  try {
    this->log_debug("drc rfdc enabled");
    API(XRFdc_CheckTileEnabled, &m_xrfdc, ty, tl)
    this->log_debug("drc rfdc enabled");
  }
  catch(...) {
    this->log_debug("drc rfdc disabled");
    ret = false;
    this->log_debug("drc rfdc disabled");
  }
#endif
  return ret;
}

template<class cfgrtr_t>
RFPort::direction_t 
RFDCDRC<cfgrtr_t>::get_direction(const std::string& rf_port_name) {
  RFPort::direction_t ret = RFPort::direction_t::rx;
  throw_if_rf_port_name_invalid(rf_port_name);
  if (m_rf_port_infos[rf_port_name].type == XRFDC_DAC_TILE) {
    ret = RFPort::direction_t::tx;
  }
  return ret;
}

template<class cfgrtr_t> double
RFDCDRC<cfgrtr_t>::get_tuning_freq_MHz(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  u32 ty = m_rf_port_infos[rf_port_name].type;
  u32 tl = m_rf_port_infos[rf_port_name].tile;
  std::vector<u32>& bl = m_rf_port_infos[rf_port_name].blocks;
  XRFdc_Mixer_Settings settings;
  memset(&settings, 0, sizeof(settings));
  API(XRFdc_GetMixerSettings, &m_xrfdc, ty, tl, bl[0], &settings)
  // for ADC NCO freq, ref https://docs.xilinx.com/r/en-US/pg269-rf-data-converter/NCO-Frequency-Conversion
  // we are designing for Nyquist zone 1,
  // "To avoid the inversion of the original spectrum, set
  // positive NCO frequencies in down conversion when the desired signal is
  // located at even Nyquist bands, or negative NCO frequencies when the desired
  // signal is located at odd Nyquist band"
  return (ty == XRFDC_ADC_TILE ? -1. : 1.) * settings.Freq/1000.;
}

template<class cfgrtr_t> double
RFDCDRC<cfgrtr_t>::get_bandwidth_3dB_MHz(const std::string& rf_port_name) {
  return get_sampling_rate_Msps(rf_port_name);
}

template<class cfgrtr_t> double
RFDCDRC<cfgrtr_t>::get_sampling_rate_Msps(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  return 90.;
}

template<class cfgrtr_t> bool
RFDCDRC<cfgrtr_t>::get_samples_are_complex(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  return true;
}

template<class cfgrtr_t> std::string
RFDCDRC<cfgrtr_t>::get_gain_mode(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  ///@TODO implement correctly
  return "manual";
}

template<class cfgrtr_t> double
RFDCDRC<cfgrtr_t>::get_gain_dB(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  ///@TODO implement correctly
  return 0;
}

template<class cfgrtr_t> uint8_t
RFDCDRC<cfgrtr_t>::get_app_port_num(const std::string& rf_port_name) {
  throw_if_rf_port_name_invalid(rf_port_name);
  ///@TODO investigate whether this is correct
  return 0;
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_direction(const std::string& rf_port_name,
    RFPort::direction_t /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_tuning_freq_MHz(const std::string& rf_port_name,
    double /*val*/) {
  ///@TODO implement XRFdc_SetMixerSettings API call and expand allowable range
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_bandwidth_3dB_MHz(const std::string& rf_port_name,
    double /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_sampling_rate_Msps(const std::string& rf_port_name,
    double /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_samples_are_complex(const std::string& rf_port_name,
    bool /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_gain_mode(const std::string& rf_port_name, const std::string& /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_gain_dB(const std::string& rf_port_name, double /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
  ///@TODO implement XRFdc_SetDSA API call and expand allowable range
#if 0
  XRFdc_DSA_Settings settings;
  memset(&settings, 0, sizeof(settings));
  u32 tl = m_rf_port_infos[rf_port_name].tile;
  std::vector<u32>& bl = m_rf_port_infos[rf_port_name].blocks;
  for (auto it = bl.begin(); it != bl.end(); ++it) {
    API(XRFdc_GetDSA, &m_xrfdc, tl, *it, &settings)
    settings.Attenuation = val;
    API(XRFdc_SetDSA, &m_xrfdc, tl, *it, &settings)
  }
#endif
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_app_port_num(const std::string& rf_port_name, uint8_t /*val*/) {
  throw_if_rf_port_name_invalid(rf_port_name);
}

/// @param[in] val must be one of XRFDC_INTERP_DECIM_* macros from xrfdc.h
template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::set_resampling_rate(const std::string& rf_port_name,
    u32 val) {
  throw_if_rf_port_name_invalid(rf_port_name);
  u32 ty = m_rf_port_infos[rf_port_name].type;
  u32 tl = m_rf_port_infos[rf_port_name].tile;
  std::vector<u32>& bl = m_rf_port_infos[rf_port_name].blocks;
  for (auto it = bl.begin(); it != bl.end(); ++it) {
    if(ty == XRFDC_ADC_TILE) {
      API(XRFdc_SetDecimationFactor, &m_xrfdc, tl, *it, val)
    }
    else {
      API(XRFdc_SetInterpolationFactor, &m_xrfdc, tl, *it, val)
    }
  }
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::dump_regs() {
  for (auto it = m_rf_port_infos.begin(); it != m_rf_port_infos.end(); ++it) {
    API_NO_RET(XRFdc_DumpRegs, &m_xrfdc, it->second.type, it->second.tile)
  }
}

template<class cfgrtr_t> rfdc_ip_version_t
RFDCDRC<cfgrtr_t>::get_fpga_rfdc_ip_version() {
  rfdc_ip_version_t ret;
  uint32_t reg_0 = get_ulong_prop(0, 0);
  ret.major = (reg_0 & 0xff000000) >> 24;
  ret.minor = (reg_0 & 0x00ff0000) >> 16;
  return ret;
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::throw_if_rf_port_name_invalid(const std::string& rf_port_name) {
  if (m_rf_port_infos.find(rf_port_name) == m_rf_port_infos.end()) {
    this->throw_invalid_rf_port_name(rf_port_name);
  }
}

/// @brief checking proof of life here since the rfdc lib does not
template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::throw_if_proof_of_life_reg_test_fails() {
  rfdc_ip_version_t version = get_fpga_rfdc_ip_version();
  // v2.5 is what's used in primitives/rfdc/vivado-gen-rfdc.tcl at time of
  // writing
  bool match = (version.major == 2) && (version.minor == 5);
  std::ostringstream oss;
  if (!match) {
    throw std::runtime_error("proof of life version register test failed");
  }
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::init_rf_port_infos(
    const std::string& rf_port_name_rx1, const std::string& rf_port_name_rx2,
    const std::string& rf_port_name_tx1, const std::string& rf_port_name_tx2) {
  rfdc_api_info_for_drc_rf_port tmp;
  tmp.type = XRFDC_ADC_TILE;
  tmp.tile = 0;
  tmp.blocks = {0, 1};
  m_rf_port_infos.emplace(rf_port_name_rx1, tmp);
  tmp.type = XRFDC_ADC_TILE;
  tmp.tile = 2;
  tmp.blocks = {0, 1};
  m_rf_port_infos.emplace(rf_port_name_rx2, tmp);
  tmp.type = XRFDC_DAC_TILE;
  tmp.tile = 3;
  tmp.blocks = {2};
  m_rf_port_infos.emplace(rf_port_name_tx1, tmp);
  tmp.type = XRFDC_DAC_TILE;
  tmp.tile = 3;
  tmp.blocks = {0};
  m_rf_port_infos.emplace(rf_port_name_tx2, tmp);
}

/*! @brief ref https://github.com/Xilinx/embeddedsw/tree/xilinx_v2021.1/XilinxProcessorIPLib/drivers/rfdc
 *         note we do NOT call XRFdc_LookupConfig() as is usually the case with
 *         this library - this is because we are not looking up by sysfs/device,
 *         we simply "register" the opencpi control plane interface as the
 *         libmetal io interface and bypass sysfs altogether since opencpi hdl
 *         containers won't have the device tree that corresponds to the sysfs
 *         entry
 ******************************************************************************/
template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::init_metal() {
  struct metal_init_params metal_param = METAL_INIT_DEFAULTS;
  metal_param.log_level = METAL_LOG_DEBUG;
  if (metal_init(&metal_param)) {
    throw std::runtime_error("metal_init failed");
  }
}

/*! @brief this is assumed to match generation parameters documented in
 *         vivado-gen-rfdc.tcl
 *         (ref https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/115966024/How+configuration+data+gets+passed+to+RFDC+driver+in+Baremetal+and+Linux)
 ******************************************************************************/
template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::init_xrfdc_config() {
  XRFdc_Config config[1];
  memset(&config, 0, sizeof(config));
  // below line is necessary to get XRFdc_SetDecimationFactor to work properly
  config[0].IPType = XRFDC_GEN3;
  // below line is necessary to get XRFdc_SetClkDistribution to work properly
  config[0].ADCType = 1;
  for(auto it = m_rf_port_infos.begin(); it != m_rf_port_infos.end(); ++it) {
    if (it->second.type == XRFDC_DAC_TILE) {
      auto& tile_config = config[0].DACTile_Config[it->second.tile];
      // below 3 lines are necessary to get GetMixerSettings to work properly
      tile_config.Enable = 1;
      tile_config.RefClkFreq = 3600.;
      tile_config.SamplingRate = 3600.;
      for (size_t idx = 0; idx <= 3; idx++) {
        tile_config.DACBlock_Digital_Config[idx].InterpolationMode = 1;
      }
    }
    else {
      auto& tile_config = config[0].ADCTile_Config[it->second.tile];
      // below 3 lines are necessary to get GetMixerSettings to work properly
      tile_config.Enable = 1;
      tile_config.RefClkFreq = 3600.;
      tile_config.SamplingRate = 3600.;
      for (size_t idx = 0; idx <= 3; idx++) {
        tile_config.ADCBlock_Digital_Config[idx].DecimationMode = 1;
      }
    }
  }
  m_xrfdc.io = &metal_io_region_; // from opencpi-modified libmetal linux layer
  API(XRFdc_CfgInitialize, &m_xrfdc, config)
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::log_xrfdc_status() {
  XRFdc_IPStatus st;
  memset(&st, 0, sizeof(st));
  API(XRFdc_GetIPStatus, &m_xrfdc, &st)
  for (u32 tl = 0; tl <= 3; tl++) {
    if (st.DACTileStatus[tl].IsEnabled) {
      this->log_debug("rfdc d tl%i en %i", tl, st.DACTileStatus[tl].IsEnabled);
      this->log_debug("rfdc d tl%i st %i", tl, st.DACTileStatus[tl].TileState);
      this->log_debug("rfdc d tl%i pu %i", tl, st.DACTileStatus[tl].PowerUpState);
      this->log_debug("rfdc d tl%i pl %i", tl, st.DACTileStatus[tl].PLLState);
    }
  }
  for (u32 tl= 0; tl <= 3; tl++) {
    if (st.ADCTileStatus[tl].IsEnabled) {
      this->log_debug("rfdc a tl%i en %i", tl, st.ADCTileStatus[tl].IsEnabled);
      this->log_debug("rfdc a tl%i st %i", tl, st.ADCTileStatus[tl].TileState);
      this->log_debug("rfdc a tl%i pu %i", tl, st.ADCTileStatus[tl].PowerUpState);
      this->log_debug("rfdc a tl%i pl %i", tl, st.ADCTileStatus[tl].PLLState);
    }
  }
}

template<class cfgrtr_t> void
RFDCDRC<cfgrtr_t>::init() {
  // https://docs.xilinx.com/r/en-US/pg269-rf-data-converter/Resets
  // https://docs.xilinx.com/r/en-US/pg269-rf-data-converter/Power-up-Sequence
  init_clock_source_devices();
  m_callback.take_rfdc_axi_lite_out_of_reset();
  const size_t RFDC_GEN3_ADC_CONVERT_CALIB_TIME_MICROSEC = 63000;
  usleep(2*RFDC_GEN3_ADC_CONVERT_CALIB_TIME_MICROSEC);
  //std::cout << "sleeping for 30 sec\n";
  //sleep(30);
  m_callback.take_rfdc_axi_stream_out_of_reset();
  init_metal();
  throw_if_proof_of_life_reg_test_fails();
  init_xrfdc_config();
  log_xrfdc_status();
}
