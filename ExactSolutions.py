# -*- coding: utf-8 -*-
"""
Exact solutions to area for delay discounting models
Shawn Gilroy, 2017
GPLv2+ Licensed
"""

import numpy as np
from scipy.special import hyp2f1

"""
Exponential Area
A = Intercept, value without delay
k = rate parameter
startDelay = lower bound of domain assessed
endDelay = upper bound of domain assessed
"""
def exactExponentialArea(A, lnk, startDelay, endDelay):
    expFinal = (-A * np.exp(-np.exp(lnk) * endDelay)) / np.exp(lnk)
    expInitial = (-A * np.exp(-np.exp(lnk) * startDelay)) / np.exp(lnk)

    return ((expFinal - expInitial) / ((endDelay - startDelay) * A))

"""
Hyperbolic Area
A = Intercept, value without delay
k = rate parameter
startDelay = lower bound of domain assessed
endDelay = upper bound of domain assessed
"""
def exactHyperbolicArea(A, hypLnk, startDelay, endDelay):
    hypFinal = (A * np.log((np.exp(hypLnk) * endDelay) + 1)) / np.exp(hypLnk);
    hypInitial = (A * np.log((np.exp(hypLnk) * startDelay) + 1)) / np.exp(hypLnk);
    
    return ((hypFinal - hypInitial) / ((endDelay - startDelay) * A))
    
"""
Beta Delta Area
A = Intercept, value without delay
beta = present moment bias (0-1)
delta = rate parameter (1 - delta)
startDelay = lower bound of domain assessed
endDelay = upper bound of domain assessed
"""
def exactBetaDeltaArea(A, beta, delta, startDelay, endDelay):
    bdFinal = (-A * beta * np.exp(-(1 - delta) * endDelay)) / (1 - delta)
    bdInitial = (-A * beta * np.exp(-(1 - delta) * startDelay)) / (1 - delta)
    
    return ((bdFinal - bdInitial) / ((endDelay - startDelay) * A))

"""
Green & Myerson Area
A = Intercept, value without delay
k = rate parameter
s = scaling parameter
startDelay = lower bound of domain assessed
endDelay = upper bound of domain assessed
"""
def exactMyersonGreenArea(A, mgLnk, mgS, startDelay, endDelay):
    mgFinal = (A * (np.power((np.exp(mgLnk) * endDelay + 1), (1 - mgS)))) / (np.exp(mgLnk) * (1 - mgS))
    mgInitial = (A * (np.power((np.exp(mgLnk) * startDelay + 1), (1 - mgS)))) / (np.exp(mgLnk) * (1 - mgS)) 
    
    return ((mgFinal - mgInitial) / ((endDelay - startDelay) * A))
    
"""
Rachlin Area
A = Intercept, value without delay
k = rate parameter
s = scaling parameter
startDelay = lower bound of domain assessed
endDelay = upper bound of domain assessed
"""
def exactRachlinArea(A, rachlinLnk, rachlinS, startDelay, endDelay):
    rachFinal = A * endDelay * hyp2f1(float(1.0), float(1.0/rachlinS), float(1 + (1.0/rachlinS)), float(-np.exp(rachlinLnk) * (endDelay )**rachlinS))
    rachInitial = A * startDelay * hyp2f1(float(1.0), float(1.0/rachlinS), float(1 + (1.0/rachlinS)), float(-np.exp(rachlinLnk) * (startDelay )**rachlinS))
    
    return ((rachFinal - rachInitial) / ((endDelay - startDelay) * A))

A = 1
T1 = 1
T2 = 17280

result = exactExponentialArea(A, -3.38131, T1, T2)
print (result)
'''
0.00164512312082
'''

result = exactHyperbolicArea(A, -3.05261, T1, T2)
print (result)
'''
0.00815965918059
'''

result = exactBetaDeltaArea(A, 1, 1-0.966569, T1, T2)
print (result)
'''
2.27757637899e-05
'''

result = exactMyersonGreenArea(A, -3.07039, 1.01292, T1, T2)
print (result)
'''
0.00793465950579
'''

result = exactRachlinArea(A, -3.37479, 1.1134, T1, T2)
print (result);
'''
0.00576847298411
'''