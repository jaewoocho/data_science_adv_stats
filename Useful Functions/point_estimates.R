#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#### Point Estimates | Forecasting ####
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

point_estimates <- function(true, estimated){
  
  ## Mean (bias) error
  me <- function(true, estimated){
    mean(true - estimated, na.rm = TRUE)
  }
  ## Mean absolute error
  mae <- function(true, estimated){
    mean(abs(true - estimated), na.rm = TRUE)
  }
  ## Root mean square error
  rmse <- function(true, estimated){
    sqrt(mean((true - estimated)^2, na.rm = TRUE))
  }
  
  return(
    c(
      # ME is made to be negative to match
      # the output of {fpp3}
      ME = -me(true, estimated),
      MAE = mae(true, estimated),
      RMSE = rmse(true, estimated)
    )
  )
  
}
