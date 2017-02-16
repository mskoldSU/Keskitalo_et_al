Keskitalo et al Bayesian source apportionment
================

This repository contains the code used for fitting a Bayesian model of smoothly varying source proportions in Keskitalo et al. See `code.R` for R-code and `model.jags` for JAGS model file. Sample run

``` r
mcmc_output <- run_jags(file = "model.jags", data = data, N = 1000000, thin = 1000)
plot_IQR(mcmc_output, data)
```

![](readme_files/figure-markdown_github/unnamed-chunk-2-1.png) *Fig: Posterior median and interquartile ranges for source proportions *
