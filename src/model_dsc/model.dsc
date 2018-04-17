#!/usr/bin/env dsc

get_data: R(dat = readRDS(data_file))
  # FIXME: see 20171103_MNMASH_Data.ipynb for GTEx multitissue data preparation
  # and implement it more formally here
  data_file: $(data_file)
  $data: dat

original_Y: Python(data['Y'] = numpy.vstack(data['Y'].values()).T)
  # do not simulate data, just use original
  data: $data
  $data: data

init_mnm: init_mnm.R
  data: $data
  # FIXME: these quantities are to be computed seperately and globally using mashr procedure
  # See http://stephenslab.github.io/gtex-eqtls/analysis/20171002_MASH_V8.html
  Sigma: empirical
  (U, grid, p): (auto, (0.9,0.01,0.01,0.01,0.01,0.01,0.01,0.02,0.02), auto)
  $data: data
  $model: model

fit_mnm: fit_mnm.R
  maxL: 5
  maxI: 10
  data: $data
  model: $model
  $fitted: fitted_track
  $posterior: posterior

fit_varbvs: setup_varbvs.R + fit_varbvs.R
  # Prior variance of nonzero effects.
  sa: 1
  maxL: 5
  maxI: 50
  data: $data
  $posterior: posterior
  $fitted: fitted

fit_susie(fit_varbvs): fit_susie.R

diagnose: elbo_mnm.R
  data: $data
  model: $model
  fitted: $fitted
  posterior: $posterior
  $diagnosed: elbo

DSC:
  define:
    get_Y: original_Y
    init: init_mnm
    fit: fit_mnm, fit_susie, fit_varbvs
  run:
    first_pass: get_data * get_Y * init * fit * diagnose
  output: mnm_model
  exec_path: modules
  lib_path: libs
  R_libs: mashr, abind, varbvs@pcarbo/varbvs/varbvs-R, susieR@stephenslab/susieR
  global:
    data_file: ~/Documents/GTExV8/Thyroid.Lung.FMO2.filled.rds