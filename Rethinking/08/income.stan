data {
  int<lower=1> n;     // number of observations
  vector[n] log_gdp_std;    // response
  vector[n] rugged_std;     // predictor
  array[n] int region;            // categorical predictor, africa or not
}
parameters {
  real<lower=0> sigma; // std of response, single continuous value
  vector[2] a; // vector of two numeric values: intercepts for Africa and Not Africa
  vector[2] b; // vector of two numeric values: slopes for Africa and Not Africa
}
model {
  vector[n] mu; // vector of n values: expected log_gdp_std for each observation
  for (i in 1:n) { // loop over the n cases in the dataset to estimate mu_i values
    mu[i] = a[region[i]] + b[region[i]] * (rugged_std[i] - 0.215); // expected log_gdp_std is region-specific intercept + region-specific slope * (rugged_std = 0.215)
  }
  a ~ normal(1, 0.1); // prior for both intercepts
  b ~ normal(0, 0.3); // prior for both slopes
  sigma ~ exponential(1); // prior for sigma
  log_gdp_std ~ normal(mu, sigma); // defining likelihood in terms of mus and sigma
}