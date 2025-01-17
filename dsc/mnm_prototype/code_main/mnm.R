prior = meta$prior[[eff_mode]]
if (is.null(prior)) {
    stop(paste("Effect mode", eff_mode, "is not available"))
}
if (resid_method == 'flash') {
    resid_Y <- compute_cov_flash(Y)
} else if (resid_method == 'diag') {
    resid_Y <- compute_cov_diag(Y)
} else {
    resid_Y <- meta$residual_variance
}
m_init = mvsusieR::create_mash_prior(mixture_prior = list(matrices=prior$xUlist, weights=prior$pi), 
                                 null_weight=prior$null_weight, max_mixture_len=-1)
result = mvsusieR::mvsusie(X, Y, L=L, prior_variance=m_init, residual_variance=resid_Y, compute_objective=T, estimate_residual_variance=F,
                      estimate_prior_variance=T, estimate_prior_method='EM', precompute_covariances=T, n_thread=n_thread, max_iter=maxiter)
result$cs_corr = susieR:::get_cs_correlation(result, X=X)