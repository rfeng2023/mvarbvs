print('artificial_mixture_ukb')
priors = readRDS('~/GitHub/mvarbvs/dsc/ukb-bloodcells/analysis_20220619/ukb_prior_simulation_20220619.rds') 
files = read.table('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/artificial_mixture_ukb/analysis_units.txt', stringsAsFactors = FALSE)$V1
for(i in 1:length(files)){
  print(i)
  dat = readRDS(paste0('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/artificial_mixture_ukb/', files[i], '.rds'))
  dat$meta$prior$ED = list(xUlist = priors[[dat$meta$eff_mode]]$ED$U, pi = priors[[dat$meta$eff_mode]]$ED$w, null_weight=0)
  saveRDS(dat, paste0('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/artificial_mixture_ukb/', files[i], '.rds'))
}

print('ukb_bloodcells_mixture')
priors = readRDS('~/GitHub/mvarbvs/dsc/ukb-bloodcells/analysis_20220619/ukb_prior_simulation_20220619.rds')
files = read.table('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/ukb_bloodcells_mixture/analysis_units.txt', stringsAsFactors = FALSE)$V1
for(i in 1:length(files)){
  print(i)
  dat = readRDS(paste0('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/ukb_bloodcells_mixture/', files[i], '.rds'))
  dat$meta$prior$ED = list(xUlist = priors[[dat$meta$eff_mode]]$ED$U, pi = priors[[dat$meta$eff_mode]]$ED$w, null_weight=0)
  saveRDS(dat, paste0('~/GitHub/mvarbvs/dsc/mnm_prototype/output/ukb_rss_20220619/ukb_bloodcells_mixture/', files[i], '.rds'))
}

