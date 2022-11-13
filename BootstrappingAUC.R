generateHyperbolic <- function(k, delays, noiseSd, id) {
  vals <- 1/(1+k*delays)

  vals <- log(vals)

  err <- rnorm(length(vals), 0, noiseSd)

  ests <- 10^(vals + err)

  ests[ests > 1] <- 1
  ests[ests < 0] <- 0

  return (data.frame(
    Delays = delays,
    Values = ests,
    ID = rep(id, length(vals))
  ))
}

HyperbolicExactArea <- function(A, hypLnk, startDelay, endDelay) {
  hypFinal = (A * log((exp(hypLnk) * endDelay) + 1)) / exp(hypLnk)
  hypInitial = (A * log((exp(hypLnk) * startDelay) + 1)) / exp(hypLnk)

  return ((hypFinal - hypInitial) / ((endDelay - startDelay) * A))
}

simulatePBAUCFit <- function(trueValues, nSims, sd,
                             model, group, study) {

  returnFrame = data.frame(
    ID    = 1:nSims,
    Study = rep(study, nSims),
    Model = rep(model, nSims),
    Group = rep(group, nSims),
    K     = rep(NA, nSims),
    S     = rep(NA, nSims),
    AUC   = rnorm(nSims, trueValues, sd)
  )

  returnFrame
}

simulateHyperbolicFit <- function(trueValues,
                                  nSims, delayValues,
                                  model, group, study,
                                  errDev = 0.05,
                                  startIntegral = 1,
                                  endIntegral = 365) {

  sampleBaseData <<- generateHyperbolic(trueValues[1],
                                        delayValues,
                                        errDev,
                                        1)

  sampleBaseFits <- nls(formula = Values ~ 1/(1+k*Delays),
                        start = c(k = trueValues[1]),
                        control = nls.control(warnOnly = TRUE),
                        data = sampleBaseData)

  ci = confint2(sampleBaseFits)

  ll <<- ci[1]
  ul <<- ci[2]
  sd <- (ul - ll) / 4

  kValues <- rnorm(nSims, trueValues, sd)

  returnFrame = data.frame(
    ID    = 1:nSims,
    Study = rep(study, nSims),
    Model = rep(model, nSims),
    Group = rep(group, nSims),
    K     = rep(NA, nSims),
    S     = rep(NA, nSims),
    AUC   = rep(NA, nSims)
  )

  for (row in 1:nSims) {
    returnFrame[row, "K"]   = kValues[row]
    returnFrame[row, "AUC"] = HyperbolicExactArea(1,
                                                  log(kValues[row]),
                                                  startIntegral,
                                                  endIntegral)
  }

  returnFrame
}

generateGreenMyerson <- function(k, s, delays, noiseSd, id) {
  vals <- 1/((1+k*delays)^s)
  vals <- log(vals)

  err <- rnorm(length(vals), 0, noiseSd)

  ests <- 10^(vals + err)

  ests[ests > 1] <- 1
  ests[ests < 0] <- 0

  return (data.frame(
    Delays = delays,
    Values = ests,
    ID = rep(id, length(vals))
  ))
}

MyersonGreenExactArea <- function(A, mgLnk, mgS, startDelay, endDelay) {
  mgFinal = (A * ((exp(mgLnk) * endDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS))
  mgInitial = (A * ((exp(mgLnk) * startDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS))

  return ((mgFinal - mgInitial) / ((endDelay - startDelay) * A))
}

simulateMyersonGreenFit <- function(trueValues,
                                  nSims, delayValues,
                                  model, group, study,
                                  errDev = 0.05,
                                  upperMult = 1.05,
                                  lowerMult = 0.95,
                                  startIntegral = 1,
                                  endIntegral = 365) {

  sampleBaseData <<- generateGreenMyerson(trueValues[1],
                                          trueValues[2],
                                          delayValues,
                                          errDev,
                                          1)

  sampleBaseFits <- nls(formula = Values ~ 1/((1+k*Delays)^s),
                        start = c(k = 1,
                                  s = 3),
                        algorithm = 'port',
                        upper = c(Inf,
                                  Inf),
                        lower = c(0.0000000000000000000000000001,
                                  0.0000000000000000000000000001),
                        control = nls.control(warnOnly = TRUE),
                        data = sampleBaseData)

  bootNumbers = as.data.frame(nlsBoot(sampleBaseFits, nSims)$coefboot)

  returnFrame = data.frame(
    ID    = 1:nSims,
    Study = rep(study, nSims),
    Model = rep(model, nSims),
    Group = rep(group, nSims),
    K     = rep(NA, nSims),
    S     = rep(NA, nSims),
    AUC   = rep(NA, nSims)
  )

  for (row in 1:nSims) {
    returnFrame[row, "K"]   = bootNumbers[row,"k"]
    returnFrame[row, "S"]   = bootNumbers[row,"s"]
    returnFrame[row, "AUC"] = MyersonGreenExactArea(1,
                                                 log(bootNumbers[row,"k"]),
                                                 bootNumbers[row,"s"],
                                                 startIntegral,
                                                 endIntegral)
  }

  returnFrame
}
