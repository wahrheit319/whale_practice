data {
  int<lower=1> n;     // number of observations
  vector[n] brozek_std;    // response
  vector[n] density_std;     // predictor
}
parameters {
  real beta_0; 
  real beta_1; 
  real<lower=0> sigma; 
}
model {
  vector[n] mu; // vector of n values: expected log_gdp_std for each observation
  for (i in 1:n) { // loop over the n cases in the dataset to estimate mu_i values
    mu[i] = beta_0 + beta_1 * density_std[i];
  }
  beta_0 ~ normal(0, 10);
  beta_1 ~ normal(0, 10);
  sigma ~ uniform(0, 10);
  brozek_std ~ normal(mu, sigma);
}