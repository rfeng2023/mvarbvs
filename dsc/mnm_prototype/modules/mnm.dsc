mnm_base: misc.R + mnm.R
  @CONF: R_libs = (mmbr@gaow/mmbr, flashier@willwerscheid/flashier)
  X: $X
  Y: $Y
  meta: $meta
  eff_mode: 'identity', 'low_het', 'mid_het', 'high_het', 'shared', 'singleton', 'singleton_1', 'mixture_1'
  L: 10
  resid_method: 'oracle', 'diag', 'flash'
  $result: result

mnm_high_het(mnm_base):
  eff_mode: 'high_het'
  resid_method: 'oracle', 'flash'

mnm_low_het(mnm_base):
  eff_mode: 'low_het'
  resid_method: 'oracle', 'flash'

mnm_mid_het(mnm_base):
  eff_mode: 'mid_het'
  resid_method: 'oracle', 'flash'

mnm_shared(mnm_base):
  eff_mode: 'shared'
  resid_method: 'oracle', 'flash'

mnm_singleton(mnm_base):
  eff_mode: 'singleton'
  resid_method: 'oracle', 'flash'

mnm_singleton_first(mnm_base):
  eff_mode: 'singleton_1'
  resid_method: 'oracle', 'flash'

mnm_mixture01(mnm_base):
  eff_mode: 'mixture_1'
  resid_method: 'oracle', 'flash'

mnm_oracle(mnm_base):
  eff_mode: 'oracle'
  resid_method: 'oracle', 'flash'

mnm_identity(mnm_base):
  eff_mode: 'identity'
  resid_method: 'oracle', 'flash'

mnm_naive(mnm_base):
  eff_mode: 'naive'
  resid_method: 'oracle', 'flash'