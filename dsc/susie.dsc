#!/usr/bin/env dsc
%include modules/zzz

DSC:
  define:
      get_data: liter_data 
  run: 
    run_susie: get_data * summarize_ld * simple_lm * fit_susie * (plot_sse, plot_susie)
    run_varbvs: get_data * summarize_ld * simple_lm * fit_varbvs * plot_sse
    run_comparison: get_data * summarize_ld * lm_less * get_sumstats * (fit_finemap, fit_dap)
  exec_path: modules
  global:
    data_file: ../data/gtex-manifest.txt
    dap_g_data: ../data/dap-manifest.txt
