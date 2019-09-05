%
% Exact solutions to area for delay discounting models
% Shawn Gilroy, 2017
% GPLv2+ Licensed
%

format long

A = 1;

T1 = 1;
T2 = 17280;

ExponentialExactArea(A, -3.38131, T1, T2)
% 0.001645123120818

HyperbolicExactArea(A, -3.05261, T1, T2)
% 0.008159659180590

BetaDeltaExactArea(A, 1, 1-0.966569, T1, T2)
% 2.277576378992093e-05

MyersonGreenExactArea(A, -3.07039, 1.01292, T1, T2)
% 0.007934659505789

RachlinExactArea(A, -3.37479, 1.1134, T1, T2)
% 0.005768472984106

function a = ExponentialExactArea(A, lnk, startDelay, endDelay)
expFinal = (-A * exp(-exp(lnk) * endDelay)) / exp(lnk);
expInitial = (-A * exp(-exp(lnk) * startDelay)) / exp(lnk);  

a = ((expFinal - expInitial) / ((endDelay - startDelay) * A));
end

function a = HyperbolicExactArea(A, hypLnk, startDelay, endDelay)
hypFinal = (A * log((exp(hypLnk) * endDelay) + 1)) / exp(hypLnk);
hypInitial = (A * log((exp(hypLnk) * startDelay) + 1)) / exp(hypLnk);

a = ((hypFinal - hypInitial) / ((endDelay - startDelay) * A));
end

function a = BetaDeltaExactArea(A, beta, delta, startDelay, endDelay)
  bdFinal = (-A * beta * exp(-(1 - delta) * endDelay)) / (1 - delta);
  bdInitial = (-A * beta * exp(-(1 - delta) * startDelay)) / (1 - delta);
  
  a = ((bdFinal - bdInitial) / ((endDelay - startDelay) * A));
end

function a = MyersonGreenExactArea(A, mgLnk, mgS, startDelay, endDelay)
  mgFinal = (A * ((exp(mgLnk) * endDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS));
  mgInitial = (A * ((exp(mgLnk) * startDelay + 1)^(1 - mgS))) / (exp(mgLnk) * (1 - mgS));
  
  a = ((mgFinal - mgInitial) / ((endDelay - startDelay) * A));
end

function a = RachlinExactArea(A, rachlinLnk, rachlinS, startDelay, endDelay)
  rachFinal   = A * endDelay * hypergeom([(1.0), (1.0/rachlinS)], (1 + (1.0/rachlinS)), (-exp(rachlinLnk) * (endDelay )^rachlinS));
  rachInitial = A * startDelay * hypergeom([(1.0), (1.0/rachlinS)], (1 + (1.0/rachlinS)), (-exp(rachlinLnk) * (startDelay )^rachlinS));
  
  a = ((rachFinal - rachInitial) / ((endDelay - startDelay) * A));
end