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

#include "DRC.hh"
#include <vector>
#include <string>
#include <sstream>
#include <cmath> // std::abs

RFPort::RFPort() :
    m_direction(RFPort::direction_t::rx),
    m_tuning_freq_MHz(-1),
    m_bandwidth_3dB_MHz(-1),
    m_sampling_rate_Msps(-1),
    m_samples_are_complex(true),
    m_gain_dB(0) {
}

RFPort::RFPort(
    RFPort::direction_t direction,
    double              tuning_freq_MHz,
    double              bandwidth_3dB_MHz,
    double              sampling_rate_Msps,
    bool                samples_are_complex,
    const std::string&  gain_mode,
    double              gain_dB) :
    m_direction(direction),
    m_tuning_freq_MHz(tuning_freq_MHz),
    m_bandwidth_3dB_MHz(bandwidth_3dB_MHz),
    m_sampling_rate_Msps(sampling_rate_Msps),
    m_samples_are_complex(samples_are_complex),
    m_gain_mode(gain_mode),
    m_gain_dB(gain_dB) {
}

std::string
to_string(const RFPort::direction_t& rhs) {
  return (rhs == RFPort::direction_t::rx ? "rx" : "tx");
}

std::string
to_string(const RFPort::config_t& rhs) {
  std::string ret;
  if (rhs == RFPort::config_t::direction)
    ret.assign("direction");
  if (rhs == RFPort::config_t::tuning_freq_MHz)
    ret.assign("tuning_freq_MHz");
  if (rhs == RFPort::config_t::bandwidth_3dB_MHz)
    ret.assign("bandwidth_3dB_MHz");
  if (rhs == RFPort::config_t::sampling_rate_Msps)
    ret.assign("sampling_rate_Msps");
  if (rhs == RFPort::config_t::samples_are_complex)
    ret.assign("samples_are_complex");
  if (rhs == RFPort::config_t::gain_mode)
    ret.assign("gain_mode");
  if (rhs == RFPort::config_t::gain_dB)
    ret.assign("gain_dB");
  return ret;
}

std::ostream&
operator<<(std::ostream& os, const RFPort::config_t& rhs) {
  os << to_string(rhs);
  return os;
}

RFPortConfigLock::RFPortConfigLock (
    const std::string& rf_port_name,
    uint8_t            rf_port_num,
    uint8_t            app_port_num) :
    m_rf_port_name(rf_port_name),
    m_rf_port_num(rf_port_num),
    m_app_port_num(app_port_num) {
}

RFPortConfigLockRequest::RFPortConfigLockRequest(
    RFPort::direction_t direction,
    double              tuning_freq_MHz,
    double              bandwidth_3dB_MHz,
    double              sampling_rate_Msps,
    bool                samples_are_complex,
    const std::string&  gain_mode,
    double              gain_dB,
    double              tolerance_tuning_freq_MHz,
    double              tolerance_bandwidth_3dB_MHz,
    double              tolerance_sampling_rate_Msps,
    double              tolerance_gain_dB,
    const std::string&  rf_port_name,
    uint8_t             rf_port_num,
    uint8_t             app_port_num) :
    RFPort(direction, tuning_freq_MHz, bandwidth_3dB_MHz, sampling_rate_Msps,
    samples_are_complex, gain_mode, gain_dB),
    RFPortConfigLock(rf_port_name, rf_port_num, app_port_num),
    m_tolerance_tuning_freq_MHz(tolerance_tuning_freq_MHz),
    m_tolerance_bandwidth_3dB_MHz(tolerance_bandwidth_3dB_MHz),
    m_tolerance_sampling_rate_Msps(tolerance_sampling_rate_Msps),
    m_tolerance_gain_dB(tolerance_gain_dB) {
}

RFPort::direction_t
RFPortConfigLockRequest::get_direction() const {
  return m_direction;
}

double
RFPortConfigLockRequest::get_tuning_freq_MHz() const {
  return m_tuning_freq_MHz;
}

double
RFPortConfigLockRequest::get_bandwidth_3dB_MHz() const {
  return m_bandwidth_3dB_MHz;
}

double
RFPortConfigLockRequest::get_sampling_rate_Msps() const {
  return m_sampling_rate_Msps;
}

bool
RFPortConfigLockRequest::get_samples_are_complex() const {
  return m_samples_are_complex;
}

const std::string&
RFPortConfigLockRequest::get_gain_mode() const {
  return m_gain_mode;
}

double
RFPortConfigLockRequest::get_gain_dB() const {
  return m_gain_dB;
}

double
RFPortConfigLockRequest::get_tolerance_tuning_freq_MHz() const {
  return m_tolerance_tuning_freq_MHz;
}

double
RFPortConfigLockRequest::get_tolerance_bandwidth_3dB_MHz() const {
    return m_tolerance_bandwidth_3dB_MHz;
}

double
RFPortConfigLockRequest::get_tolerance_sampling_rate_Msps() const {
  return m_tolerance_sampling_rate_Msps;
}

double
RFPortConfigLockRequest::get_tolerance_gain_dB() const {
  return m_tolerance_gain_dB;
}

const std::string&
RFPortConfigLockRequest::get_rf_port_name() const {
  return m_rf_port_name;
}

uint8_t
RFPortConfigLockRequest::get_rf_port_num() const {
  return m_rf_port_num;
}

uint8_t
RFPortConfigLockRequest::get_app_port_num() const {
  return m_app_port_num;
}

const CSPSolver::FeasibleRegionLimits&
CSPBase::get_feasible_region_limits() const {
  return m_solver.get_feasible_region_limits();
}

double
CSPBase::get_feasible_region_limits_min_double(const std::string& var) const {
  return m_solver.get_feasible_region_limits_min_double(var.c_str());
}

template<typename T> bool
CSPBase::val_is_within_var_feasible_region(T val,
    const std::string& var) const {
  return m_solver.val_is_within_var_feasible_region(val, var.c_str());
}

template<class CSP> const std::string&
Configurator<CSP>::get_error() const {
  return m_error;
}

template<class CSP> double
Configurator<CSP>::get_config_locked_value(const std::string& rf_port_name,
    RFPort::config_t cfg, double attempted_val) const {
  double ret = attempted_val;
  auto var = m_dict.at(rf_port_name).at(cfg);
  if (!m_solver.val_is_within_var_feasible_region(attempted_val, var))
    ret = m_solver.get_feasible_region_limits_min_double(var);
  return ret;
}

template<class CSP> template<typename T> std::string
Configurator<CSP>::get_lock_config_str(const std::string& rf_port_name,
    RFPort::config_t cfg, T val, bool succeeded) {
  std::ostringstream oss;
  oss << "lock " << (succeeded ? "SUCCEEDED " : "FAILED ");
  oss << "for rf_port_name: " << rf_port_name << " for config: " << cfg << " ";
  oss << "for value: " << val;
  return oss.str();
}

template<class CSP> bool
Configurator<CSP>::get_csp_var_is_locked(const std::string& csp_var) const {
  return (m_locked_csp_vars.find(csp_var) != m_locked_csp_vars.end());
}

template<class CSP> const CSPSolver::FeasibleRegionLimits&
Configurator<CSP>::get_feasible_region_limits() const {
  return m_solver.get_feasible_region_limits();
}

template<class CSP> double
Configurator<CSP>::get_feasible_region_limits_min_double(
    const std::string& var) const {
  return m_solver.get_feasible_region_limits_min_double(var);
}

template<class CSP> bool
Configurator<CSP>::val_is_within_var_feasible_region(
    double val, const std::string& var) const {
  return m_solver.val_is_within_var_feasible_region(val, var);
}

template<class CSP> bool
Configurator<CSP>::lock_config(const std::string& rf_port_name,
    RFPort::config_t cfg, int32_t val) {
  bool ret = lock_csp_var(m_dict.at(rf_port_name).at(cfg), val);
  std::string msg = get_lock_config_str<int32_t>(rf_port_name, cfg, val, ret);
#ifndef DISABLE_LOG
  this->log_info("%s", msg.c_str());
#endif
  if (!ret)
    m_error.assign(msg);
  return ret;
}

template<class CSP> bool
Configurator<CSP>::lock_config(const std::string& rf_port_name,
    RFPort::config_t cfg, double val, double tol) {
  bool ret = lock_csp_var(m_dict.at(rf_port_name).at(cfg), val, tol);
  std::ostringstream oss;
  oss << get_lock_config_str<double>(rf_port_name, cfg, val, ret);
  oss << " w/ tolerance: +/- " << tol;
#ifndef DISABLE_LOG
  this->log_info("%s", oss.str().c_str());
#endif
  if (!ret)
    m_error.assign(oss.str());
  return ret;
}

template<class CSP> void
Configurator<CSP>::unlock_config(const std::string& rf_port_name,
    RFPort::config_t cfg) {
  unlock_csp_var(m_dict.at(rf_port_name).at(cfg));
}

template<class CSP> void
Configurator<CSP>::unlock_all() {
  auto it = m_locked_csp_vars.begin();
  while(it != m_locked_csp_vars.end()) {
    unlock_csp_var(it->first);
    it = m_locked_csp_vars.begin();
  }
}

template<class CSP> bool
Configurator<CSP>::lock_csp_var(const std::string& var, int32_t val) {
  //std::cout << "[DEBUG] lock_csp_var " << var << " " << val << "\n";
  bool ret = false;
  if (!get_csp_var_is_locked(var)) {
    auto& solver = m_solver.m_solver;
    size_t lo = solver.add_constr(var, "=", val);
    ret = !solver.feasible_region_limits_is_empty_for_var(var);
    if (ret) {
      Configurator<CSP>::CSPVarLockInfo in = {lo, 0, val, 0, false};
      m_locked_csp_vars.insert(std::pair<std::string, CSPVarLockInfo>(var, in));
    }
    else { // backtrack (https://en.wikipedia.org/wiki/Backtracking)
      solver.remove_constr(lo);
    }
  }
  //std::cout << "[DEBUG] " << get_feasible_region_limits() << "\n";
  //std::cout << "[DEBUG] " << m_solver.m_solver << "\n";
  return ret;
}

template<class CSP> bool
Configurator<CSP>::lock_csp_var(const std::string& var, double val,
    double tolerance) {
  //std::cout << "[DEBUG] lock_csp_var " << var << " " << val << "\n";
  bool ret = false;
  if (!get_csp_var_is_locked(var)) {
    double tol = tolerance;
    auto& solver = m_solver.m_solver;
    size_t lo = solver.add_constr(var, ">=", val-tol);
    size_t hi = solver.add_constr(var, "<=", val+tol);
    // test whether the lock was successful:
    // if overconstrained such that the feasible region contains an empty set
    // for the variable (var), the lock was unsuccessful and the constraints are
    // therefore rolled back (removed) to their original values
    ret = !solver.feasible_region_limits_is_empty_for_var(var);
    if (ret) {
      Configurator<CSP>::CSPVarLockInfo in = {lo, hi, 0, val, true};
      m_locked_csp_vars.insert(std::pair<std::string,CSPVarLockInfo>(var, in));
    }
    else { // backtrack (https://en.wikipedia.org/wiki/Backtracking)
      solver.remove_constr(lo);
      solver.remove_constr(hi);
    }
  }
  //std::cout << "[DEBUG] " << get_feasible_region_limits() << "\n";
  //std::cout << "[DEBUG] " << m_solver.m_solver << "\n";
  return ret;
}

template<class CSP> void
Configurator<CSP>::unlock_csp_var(const std::string& csp_var) {
  //std::cout << "[DEBUG] unlock_csp_var " << csp_var << "\n";
  if (get_csp_var_is_locked(csp_var)) {
    auto& tmp = m_locked_csp_vars.at(csp_var);
    m_solver.m_solver.remove_constr(m_locked_csp_vars.at(csp_var).m_constr_lo_id);
    // The high constraint is used for double floating point locks,
    // but not for int32.
    if (m_locked_csp_vars.at(csp_var).m_lock_val_is_double)
      m_solver.m_solver.remove_constr(tmp.m_constr_hi_id);
    m_locked_csp_vars.erase(m_locked_csp_vars.find(csp_var));
  }
  else {
    throw std::runtime_error("attempted unlock for csp_var not locked");
  }
  //std::cout << "[DEBUG] " << get_feasible_region_limits() << "\n";
  //std::cout << "[DEBUG] " << m_solver.m_solver << "\n";
}

template<class C>
DRC<C>::DRC(const std::string& descriptor) : m_descriptor(descriptor),
    m_cache_initialized(false) {
}

template<class C> void
DRC<C>::set_configuration(uint16_t config_idx,
    const Configuration& configuration) {
  m_configurations[config_idx] = configuration;
  m_pending_configuration[config_idx] = true;
}

template<class C> bool
DRC<C>::prepare(uint16_t config_idx) {
  bool ret = !m_pending_configuration[config_idx];
  if (m_locks.find(config_idx) == m_locks.end())
    if (m_pending_configuration[config_idx]) {
      if (request_config_lock(config_idx)) {
        ret = true;
        m_pending_configuration[config_idx] = false;
      }
    }
  return ret;
}

template<class C> bool
DRC<C>::start(uint16_t config_idx) {
  return prepare(config_idx);
}

template<class C> bool
DRC<C>::stop(uint16_t /*config_idx*/) {
  return true;
}

template<class C> bool
DRC<C>::release(uint16_t config_idx) {
  if (m_locks.find(config_idx) != m_locks.end())
    unlock_config_lock(config_idx);
  return stop(config_idx);
}

template<class C> void
DRC<C>::release_all() {
  for (auto it = m_locks.begin(); it != m_locks.end(); ++it)
    unlock_config_lock(it->first);
}

template<class C> const std::string&
DRC<C>::get_descriptor() const {
  return m_descriptor;
}

template<class C> const std::string&
DRC<C>::get_error() const {
  return (m_error.empty() ? m_configurator.get_error() : m_error);
}

template<class C> const std::map<uint16_t,ConfigLock>&
DRC<C>::get_locks() const {
  return m_locks;
}

template<class C> bool
DRC<C>::request_config_lock(uint16_t config_idx) {
  bool ret = false;
  auto& req = m_configurations[config_idx];
  if (!m_cache_initialized) {
    initialize_cache();
    m_cache_initialized = true;
  }
  ConfigLock config_lock;
  for (auto it = req.begin(); it != req.end(); ++it) {
    auto dir = it->get_direction();
#ifndef DISABLE_LOG
    auto id = config_idx;
    this->log_info("request ID: %i direction: %s", id, to_string(dir).c_str());
#endif
    bool found_lock = false;
    for (auto itports = m_cache.begin(); itports != m_cache.end(); ++itports) {
      if (!it->get_rf_port_name().empty()) {
        if (itports->first.compare(it->get_rf_port_name()))
          continue;
        else
          if (!get_enabled(itports->first)) {
            std::ostringstream oss;
            oss << "requested config lock specifically for rf_port_name ";
            oss << it->get_rf_port_name() << ", which is not currently enabled";
            throw std::runtime_error(oss.str());
          }
      }
      found_lock |= attempt_rf_port_config_locks(itports->first, *it);
      const std::string& pp = itports->first;
      if (found_lock) {
#ifndef DISABLE_LOG
        this->log_info("rf_port_name %s met lock requirements", pp.c_str());
#endif
        RFPortConfigLock lock = *(RFPortConfigLock*)(&(*it));
        lock.m_rf_port_name = pp;
        config_lock.push_back(lock);
        break;
      }
#ifndef DISABLE_LOG
      this->log_info("rf_port_name %s did not meet requirements", pp.c_str());
#endif
    }
    if (!found_lock) {
      ret = false;
      break;
    }
    ret = true;
  }
  if (ret) {
    m_locks[config_idx] = config_lock;
#ifndef DISABLE_LOG
    this->log_info("request lock %i succeeded", config_idx);
#endif
  }
  else { // backtrack (https://en.wikipedia.org/wiki/Backtracking)
    for (auto it = config_lock.begin(); it != config_lock.end(); ++it) {
      unlock_rf_port(it->m_rf_port_name);
    }
  }
  return ret;
}

template<class C> void
DRC<C>::unlock_config_lock(uint16_t config_idx) {
  bool found_config_lock = false;
  if (m_locks.find(config_idx) != m_locks.end()) {
    found_config_lock = true;
    auto it = m_locks.at(config_idx).begin();
    for (; it != m_locks.at(config_idx).end(); ++it) {
      unlock_rf_port(it->m_rf_port_name);
    }
    m_locks.erase(m_locks.find(config_idx));
  }
  if (!found_config_lock) {
    std::ostringstream oss;
    oss << "for config unlock request, config lock ID " << config_idx;
    oss << " not found";
    throw std::runtime_error(oss.str());
  }
}

template<class C> void
DRC<C>::unlock_all() {
  m_configurator.unlock_all();
  m_locks.clear();
}

template<class C> void
DRC<C>::initialize_cache() {
#ifndef DISABLE_LOG
  this->log_info("initializing cache");
#endif
  auto& cfgrtr = m_configurator;
  // initialize the correct number (and names, using the configurator dict as
  // the authority) of cached RF ports
  for (auto it = cfgrtr.m_dict.begin(); it != cfgrtr.m_dict.end(); ++it)
    m_cache[it->first] = RFPort();
  for (auto it = m_cache.begin(); it != m_cache.end(); ++it) {
    it->second.m_direction           = get_direction(          it->first);
    it->second.m_tuning_freq_MHz     = get_tuning_freq_MHz(    it->first);
    it->second.m_bandwidth_3dB_MHz   = get_bandwidth_3dB_MHz(  it->first);
    it->second.m_sampling_rate_Msps  = get_sampling_rate_Msps( it->first);
    it->second.m_samples_are_complex = get_samples_are_complex(it->first);
    it->second.m_gain_mode           = get_gain_mode(          it->first);
    it->second.m_gain_dB             = get_gain_dB(            it->first);
    //it->second.m_is_locked           = false;
    std::string di;
    if (it->second.m_direction == RFPort::direction_t::tx)
      di = "tx";
    else
      di = "rx";
    const char* port = it->first.c_str();
#ifndef DISABLE_LOG
    this->log_info("cache[%s][direction]          = %s", port, di.c_str());
#endif
    double val =       it->second.m_tuning_freq_MHz;
#ifndef DISABLE_LOG
    this->log_info("cache[%s][tuning_freq_MHz]    = %f", port, val);
#endif
    val =              it->second.m_bandwidth_3dB_MHz;
#ifndef DISABLE_LOG
    this->log_info("cache[%s][bandwidth_3dB_MHz]  = %f", port, val);
#endif
    val =              it->second.m_sampling_rate_Msps;
#ifndef DISABLE_LOG
    this->log_info("cache[%s][sampling_rate_Msps] = %f", port, val);
#endif
    std::string sval = (it->second.m_samples_are_complex ? "true" : "false");
#ifndef DISABLE_LOG
    this->log_info("cache[%s][samples_are_complex]= %s", port, sval.c_str());
#endif
    std::string& gm = it->second.m_gain_mode;
#ifndef DISABLE_LOG
    this->log_info("cache[%s][gain_mode]          = %s", port, gm.c_str());
#endif
    val =              it->second.m_gain_dB;
#ifndef DISABLE_LOG
    this->log_info("cache[%s][gain_dB]            = %f", port, val);
#endif
  }
}

/*! @param[in] do_tol  Instructs usage of the tolerance
 *  @return    Boolean indicator of success.
 ******************************************************************************/
template<class C> bool
DRC<C>::lock_config(const std::string& rf_port, RFPort::config_t cfg,
    double val, bool do_tol, double tol) {
  bool ret = false;
  // the configurator, which is a software emulation of hardware capabilities,
  // tells us whether a hardware attempt to set value will corrupt
  // any existing locks
  if (do_tol)
    ret = m_configurator.lock_config(rf_port, cfg, val, tol);
  else
    ret = m_configurator.lock_config(rf_port, cfg, val);
  // if configurator suceeded, handoff to the "controller" hardware actuations
  if (ret) {
    double cfglval;
    cfglval = m_configurator.get_config_locked_value(rf_port, cfg, val);
    if (cfg == RFPort::config_t::direction) {
      if (m_cache[rf_port].m_direction != (RFPort::direction_t)val) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request direction %s, set %f", (val > 0.5 ? "tx" : "rx"), (val > 0.5 ? "tx" : "rx"));
#endif
        set_direction(rf_port, (RFPort::direction_t)cfglval);
        m_cache[rf_port].m_direction = (RFPort::direction_t)cfglval;
      }
    }
    else if (cfg == RFPort::config_t::tuning_freq_MHz) {
      if (std::abs(m_cache[rf_port].m_tuning_freq_MHz-val) > tol) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request tuning_freq %f, set %f", val, cfglval);
#endif
        set_tuning_freq_MHz(rf_port, cfglval);
        m_cache[rf_port].m_tuning_freq_MHz = cfglval;
      }
    }
    else if (cfg == RFPort::config_t::bandwidth_3dB_MHz) {
      if (std::abs(m_cache[rf_port].m_bandwidth_3dB_MHz-val) > tol) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request bandwidth %f, set %f", val, cfglval);
#endif
        set_bandwidth_3dB_MHz(rf_port, cfglval);
        m_cache[rf_port].m_bandwidth_3dB_MHz = cfglval;
      }
    }
    else if (cfg == RFPort::config_t::sampling_rate_Msps) {
      if (std::abs(m_cache[rf_port].m_sampling_rate_Msps-val) > tol) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request sampling_rate %f, set %f",val, cfglval);
#endif
        set_sampling_rate_Msps(rf_port, cfglval);
        m_cache[rf_port].m_sampling_rate_Msps = cfglval;
      }
    }
    else if (cfg == RFPort::config_t::samples_are_complex) {
      bool tmp = (((int32_t)cfglval) == 1);
      if (m_cache[rf_port].m_samples_are_complex != tmp) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request complex %i, set %i",(int)tmp, (int)tmp);
#endif
        set_samples_are_complex(rf_port, tmp);
        m_cache[rf_port].m_samples_are_complex = tmp;
      }
    }
    else if (cfg == RFPort::config_t::gain_mode) {
      std::string xx = (((int32_t)cfglval) == 0 ? "auto" : "manual");
#ifndef DISABLE_LOG
      this->log_debug("drc: request gmode %s, set %s", xx.c_str(), xx.c_str());
#endif
      if (m_cache[rf_port].m_gain_mode != xx) {
        set_gain_mode(rf_port, xx);
        m_cache[rf_port].m_gain_mode = xx;
      }
    }
    else if (cfg == RFPort::config_t::gain_dB) {
      if (std::abs(m_cache[rf_port].m_gain_dB-val) > tol) {
#ifndef DISABLE_LOG
        this->log_debug("drc: request gain %f, set %f",val, cfglval);
#endif
        set_gain_dB(rf_port, cfglval);
        m_cache[rf_port].m_gain_dB = cfglval;
      }
    }
  }
  return ret;
}

template<class C> void
DRC<C>::unlock_config(const std::string& rf, RFPort::config_t cfg) {
  std::ostringstream oss;
  oss << cfg;
  std::string str = oss.str();
#ifndef DISABLE_LOG
  log_info("for rf_port_name %s: unlocking config %s", rf.c_str(), str.c_str());
#endif
  m_configurator.unlock_config(rf, cfg);
}

template<class C> void
DRC<C>::unlock_rf_port(const std::string& rf_port_name) {
  if (!m_cache[rf_port_name].m_gain_mode.compare("manual"))
    unlock_config(rf_port_name, RFPort::config_t::gain_dB);
  unlock_config(rf_port_name, RFPort::config_t::gain_mode);
  unlock_config(rf_port_name, RFPort::config_t::samples_are_complex);
  unlock_config(rf_port_name, RFPort::config_t::sampling_rate_Msps);
  unlock_config(rf_port_name, RFPort::config_t::bandwidth_3dB_MHz);
  unlock_config(rf_port_name, RFPort::config_t::tuning_freq_MHz);
  unlock_config(rf_port_name, RFPort::config_t::direction);
}

/// @brief attempt configurator and controller locking for a single rf port
template<class C> bool
DRC<C>::attempt_rf_port_config_locks(const std::string& rf_port_name,
    const RFPortConfigLockRequest& req) {
  typedef RFPort::config_t cfg_t;
  bool ret = true;
  size_t backtrack_count = 0;
  if (ret) {
    // RFPort::direction_t is mapped to int32_t in the CSP var
    RFPort::direction_t val = req.get_direction();
    ret = lock_config(rf_port_name, cfg_t::direction, (int32_t)val, false, 0);
    backtrack_count = ret ? backtrack_count : 0;
  }
  if (ret) {
    double val = req.get_tuning_freq_MHz();
    double tol = req.get_tolerance_tuning_freq_MHz();
#ifndef DISABLE_LOG
  this->log_info("locking tuning");
#endif
    ret = lock_config(rf_port_name, cfg_t::tuning_freq_MHz, val, true, tol);
    backtrack_count = ret ? backtrack_count : 1;
  }
  if (ret) {
#ifndef DISABLE_LOG
  this->log_info("locking tuning succeeded");
#endif
    double val = req.get_bandwidth_3dB_MHz();
    double tol = req.get_tolerance_bandwidth_3dB_MHz();
    ret = lock_config(rf_port_name, cfg_t::bandwidth_3dB_MHz, val, true, tol);
    backtrack_count = ret ? backtrack_count : 2;
  }
  if (ret) {
    double val = req.get_sampling_rate_Msps();
    double tol = req.get_tolerance_sampling_rate_Msps();
    ret = lock_config(rf_port_name, cfg_t::sampling_rate_Msps, val, true, tol);
    backtrack_count = ret ? backtrack_count : 3;
  }
  if (ret) {
    double val = (double)req.get_samples_are_complex();
    ret = lock_config(rf_port_name, cfg_t::samples_are_complex, val, false, 0);
    backtrack_count = ret ? backtrack_count : 4;
  }
  auto gain_mode_str = req.get_gain_mode();
  if (ret) {
    if (gain_mode_str.compare("auto") && gain_mode_str.compare("manual")) {
      ret = false;
      this->m_error = "requested unsupported gain mode";
      backtrack_count = 5;
    }
    else {
      double val = gain_mode_str == "auto" ? 0 : 1;
      ret = lock_config(rf_port_name, cfg_t::gain_mode, val, false, 0);
      backtrack_count = ret ? backtrack_count : 5;
    }
  }
  if (ret && gain_mode_str == "manual") {
    auto val = req.get_gain_dB();
    auto tol = req.get_tolerance_gain_dB();
    ret = lock_config(rf_port_name, cfg_t::gain_dB, val, true, tol);
    backtrack_count = ret ? backtrack_count : 6;
  }
  if (!ret) { // backtrack (https://en.wikipedia.org/wiki/Backtracking)
    // note that lock_config() already backtracked the particular cfg_t whose
    // lock was attempted, that is why gain_dB is never unlocked here
    if (backtrack_count >= 6)
      unlock_config(rf_port_name, cfg_t::gain_mode);
    if (backtrack_count >= 5)
      unlock_config(rf_port_name, cfg_t::samples_are_complex);
    if (backtrack_count >= 4)
      unlock_config(rf_port_name, cfg_t::sampling_rate_Msps);
    if (backtrack_count >= 3)
      unlock_config(rf_port_name, cfg_t::bandwidth_3dB_MHz);
    if (backtrack_count >= 2)
      unlock_config(rf_port_name, cfg_t::tuning_freq_MHz);
    if (backtrack_count >= 1)
      unlock_config(rf_port_name, cfg_t::direction);
  }
  //std::cout << "[INFO] " << m_solver.get_feasible_region_limits() << "\n";
  return ret;
}

template<class C> void
DRC<C>::throw_invalid_rf_port_name(const std::string& rf_port_name) const {
  throw std::runtime_error(std::string("invalid rf_port_name: ")+rf_port_name);
}
