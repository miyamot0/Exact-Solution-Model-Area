#
# Exact solutions to area for delay discounting models
# Shawn Gilroy, 2017
# GPLv2+ Licensed
#

library(gsl)

ExponentialExactArea <- function(A, lnk, startDelay, endDelay) {
  expFinal = (-A * exp(-exp(lnk) * endDelay)) / exp(lnk)
  expInitial = (-A * exp(-exp(lnk) * startDelay)) / exp(lnk)
  
  return ((expFinal - expInitial) / ((endDelay - startDelay) * A))
}

HyperbolicExactArea <- function(A, hypLnk, startDelay, endDelay) {
  hypFinal = (A * log((exp(hypLnk) * endDelay) + 1)) / exp(hypLnk)
  hypInitial = (A * log((exp(hypLnk) * startDelay) + 1)) / exp(hypLnk)
  
  return ((hypFinal - hypInitial) / ((endDelay - startDelay) * A))
}

BetaDeltaExactArea <- function(A, beta, delta, startDelay, endDelay) {
  bdFinal = (-A * beta * exp(-(1 - delta) * endDelay)) / (1 - delta)
  bdInitial = (-A * beta * exp(-(1 - delta) * startDelay)) / (1 - delta)
  
  return ((bdFinal - bdInitial) / ((endDelay - startDelay) * A))
}

MyersonGreenExactArea <- function(A, mgLnk, mgS, startDelay, endDelay) {
  mgFinal = (A * ((exp(mgLnk) * endDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS))
  mgInitial = (A * ((exp(mgLnk) * startDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS))
  
  return ((mgFinal - mgInitial) / ((endDelay - startDelay) * A))
}

#
# Credit: Stéphane Laurent <laurent_step at yahoo.fr>
# Source: https://stats.stackexchange.com/questions/33451/computation-of-hypergeometric-function-in-r
# Licensed CC-BY-SA 3.0, as Per SA Guidelines
#
Gauss2F1 <- function(a,b,c,x){
  if(x>=0 & x<1){
    hyperg_2F1(a,b,c,x)
  }else{
    hyperg_2F1(c-a,b,c,1-1/(1-x))/(1-x)^b
  }
}

RachlinExactArea <- function(A, rachlinLnk, rachlinS, startDelay, endDelay) {
  rachFinal   <- A * endDelay * Gauss2F1((1.0), (1.0/rachlinS), (1 + (1.0/rachlinS)), (-exp(rachlinLnk) * (endDelay )^rachlinS))
  rachInitial <- A * startDelay * Gauss2F1((1.0), (1.0/rachlinS), (1 + (1.0/rachlinS)), (-exp(rachlinLnk) * (startDelay )^rachlinS))
  
  return ((rachFinal - rachInitial) / ((endDelay - startDelay) * A))
}

A = 1

T1 = 1
T2 = 17280

ExponentialExactArea(A, -3.38131, T1, T2)
# [1] 0.001645123

HyperbolicExactArea(A, -3.05261, T1, T2)
# [1] 0.008159659

BetaDeltaExactArea(A, 1, 1-0.966569, T1, T2)
# [1] 2.277576e-05

MyersonGreenExactArea(A, -3.07039, 1.01292, T1, T2)
# [1] 0.00793466

RachlinExactArea(A, -3.37479, 1.1134, T1, T2)
# [1] 0.005768473
