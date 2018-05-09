#!/usr/bin/env dsc
%include modules/zzz

DSC:
  define:
    setup: (full_data, lite_data, liter_data) * summarize_ld
    get_response: base_sim, original_Y
  run:
    run_finemap: setup * get_response * get_sumstats * fit_finemap * plot_finemap
    run_finemap_uni: dap_g_data * original_Y * get_sumstats * fit_finemap * plot_finemap
    run_caviar_uni: dap_g_data * original_Y * get_sumstats * fit_caviar * plot_caviar
  output: benchmark
  exec_path: modules
  global:
    data_file: ~/Documents/GTExV8/Thyroid.Lung.FMO2.filled.rds
    dap_g_data: ../data/sim.r.geno.rds