run_jags <- function(file, data, N, thin){
  # Convenience function for running JAGS
  #
  # Arguments
  # file: file containing JAGS model code
  # data: core data, 78 observations of (year, d13C, D14C) with possibly missing values
  # N: number of samples
  # thin: subsampling interval
  #
  # Output: an mcarray containing source-proportions corresponding to each observation
  
  # Construct spline basis
  support <- data$year[1:37]
  knot <- median(support)
  X1 <- bs(support, knots = knot, intercept = TRUE)
  support <- data$year[38:61]
  knot <- median(support)
  X2 <- bs(support, knots = knot, intercept = TRUE)
  support <- data$year[62:78]
  knot <- median(support)
  X3 <- bs(support, knots = knot, intercept = TRUE)
  k <- 5 # Basis dim
  
  # Prepare for JAGS
  jags.data <- list(X1 = X1, X2 = X2, X3 = X3,
                    y.13 = data$d13C,
                    y.14 = data$D14C,
                    k = k)
  jags.inits <- list(b11 = rep(0, k), b21 = rep(0, k), 
                b12 = rep(0, k), b22 = rep(0, k), 
                b13 = rep(0, k), b23 = rep(0, k))
  # Run JAGS
  jm <- jags.model(file,
                   data = jags.data,
                   inits = jags.inits,
                   n.chains = 1, quiet=TRUE)
  jags.samples(jm, c("p.IC", "p.TS", "p.M", "mIC.13", "mIC.14", "mTS.13", "mTS.14", 
                     "mM.13", "mM.14", "scale.13", "scale.14", "lambda"),
               n.iter = N, thin = thin)
}


plot_IQR <- function(output, data){
  # Convenience function for plotting posterior interquartile ranges
  #
  # Arguments 
  # output: an mcarray produced by run_jags
  # data: core data, 78 observations of (year, d13C, D14C) with possibly missing values
  #
  # Output
  # a ggplot2 object
  p <- c(.25, .5, .75) # IQR and median
  core <- c(rep("0-1500",37),rep("8000-8500",24),rep("9300-9600",17))
  p_IC_IQR <- apply(output$p.IC[, , 1], 1, quantile, probs = p) %>% 
    t %>% 
    as.data.frame %>% 
    mutate(year = data$year, core = core, source = "IC")
  p_TS_IQR <- apply(output$p.TS[, , 1], 1, quantile, probs = p) %>% 
    t %>% 
    as.data.frame %>% 
    mutate(year = data$year, core = core, source = "TS")
  p_M_IQR <- apply(output$p.M[, , 1], 1, quantile, probs = p) %>% 
    t %>% 
    as.data.frame %>% 
    mutate(year = data$year, core = core, source = "M")
  rbind(p_IC_IQR, p_TS_IQR, p_M_IQR) %>% 
    ggplot(aes(x = year))+  
    geom_ribbon(aes(ymax = `75%`, ymin = `25%`, fill = source), alpha = 0.2) +
    geom_line(aes(x = year, y = `50%`, color = source), lwd = 1)+
    theme_bw() +
    ylab("source fraction") +
    xlab("Cal yrs BP") +
    facet_grid(. ~ core, scales = "free_x", space = "free_x") + 
    ylim(c(0, 1)) +
    scale_x_continuous(breaks = seq(0, 9500, by = 100)) +
    theme(strip.background = element_blank(), strip.text.x = element_blank(),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
          legend.position=c(0.08, 0.85))
}
