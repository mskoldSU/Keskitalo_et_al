Keskitalo et al Bayesian source apportionment
================

This repository contains the code used for fitting a Bayesian model of smoothly varying source proportions in ["Sources and characteristics of terrestrial carbon in Holocene-scale sediments of the East Siberian Sea", *Clim. Past*, 13, 1213-1226, 2017](https://doi.org/10.5194/cp-13-1213-2017)

See `code.R` for R-code and `model.jags` for JAGS model file. Sample run

``` r
mcmc_output <- run_jags(file = "model.jags", data = data, N = 1000000, thin = 1000)
plot_IQR(mcmc_output, data)
```

![](readme_files/figure-markdown_github/unnamed-chunk-2-1.png)

*Figure: Posterior median and interquartile ranges for source proportions*

``` r
sessionInfo()
```

    ## R version 3.4.4 (2018-03-15)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 16299)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=Swedish_Sweden.1252  LC_CTYPE=Swedish_Sweden.1252   
    ## [3] LC_MONETARY=Swedish_Sweden.1252 LC_NUMERIC=C                   
    ## [5] LC_TIME=Swedish_Sweden.1252    
    ## 
    ## attached base packages:
    ## [1] splines   stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ## [1] bindrcpp_0.2  rjags_4-6     coda_0.19-1   dplyr_0.7.4   ggplot2_2.2.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.16     bindr_0.1.1      knitr_1.20       magrittr_1.5    
    ##  [5] munsell_0.4.3    lattice_0.20-35  colorspace_1.3-2 R6_2.2.2        
    ##  [9] rlang_0.2.0      stringr_1.3.0    plyr_1.8.4       tools_3.4.4     
    ## [13] grid_3.4.4       gtable_0.2.0     htmltools_0.3.6  yaml_2.1.18     
    ## [17] lazyeval_0.2.1   rprojroot_1.3-2  digest_0.6.15    assertthat_0.2.0
    ## [21] tibble_1.4.2     reshape2_1.4.3   glue_1.2.0       evaluate_0.10.1 
    ## [25] rmarkdown_1.9    labeling_0.3     stringi_1.1.7    compiler_3.4.4  
    ## [29] pillar_1.2.1     scales_0.5.0     backports_1.1.2  pkgconfig_2.0.1
