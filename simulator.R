#    Copyright 2016 Chris Franck
#
#    This file is part of Discounting Model Selector.
#
#    Discounting Model Selector is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 2.
#
#    Discounting Model Selector is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Discounting Model Selector.  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>.
#

### This function generates discounting data and provides true ED50 value - now with BD

#N = number of participants
#pvect is a vector of probabilities:
#   1 Mazur prob
#   2 Exponential prob
#   3 MG prob
#   4 Rachlin prob
#   5 Quasi hyperbolic (BD)
#mulnk.Mazur and siglnk.Mazur are mean and sd of ln(k) values among subjects
#MSE is the error variance in this group

Multifunct_sim<-function(N,pvect,
                         mulnk.Mazur,siglnk.Mazur,
                         mulnk.exp,siglnk.exp,
                         MG.loc,MG.scale,Rachlin.loc,Rachlin.scale,
                         BD.betalow,BD.betahigh,BD.deltalow,BD.deltahigh, #Generate from uniforms
                         MSE){
  library(mvtnorm)
  Xrun<-c(1,7,14,30,183,365,1825,9125)
  n<-length(Xrun)
  
  #Sample from multinomial to set true discounting type, create true ID vector
  
  rawID<-sample(c('Mazur','exp','MG','Rachlin','BD'),N,replace=TRUE,prob=pvect)
  numID<-1*(rawID=='Mazur')+  2*(rawID=='exp')+  3*(rawID=='MG')+  4*(rawID=='Rachlin')+  5*(rawID=='BD')
  
  ID<-data.frame(rawID,numID)[order(numID),1]
    
  #How many of each session?
  nMazur<-sum(ID=='Mazur')
  nexp<-sum(ID=='exp')
  nMG<-sum(ID=='MG')
  nRachlin<-sum(ID=='Rachlin')
  nBD<-sum(ID=='BD')
    
  #Generate Mazur lnks 
  if(nMazur>0){
  lnk.Mazur.short<-rnorm(nMazur,mulnk.Mazur,siglnk.Mazur) #creates lnk for each of the nMazur subjects
  lnk.Mazur<-rep(lnk.Mazur.short,each=n) #replicates the parameter length(Xrun) times
  }else{lnk.Mazur.short<-NULL
        lnk.Mazur<-NULL}
    
  #Generate exponential lnks 
  if(nexp>0){
  lnk.exp.short<-rnorm(nexp,mulnk.exp,siglnk.exp)
  lnk.exp<-rep(lnk.exp.short,each=n)
  }else{lnk.exp.short<-NULL
        lnk.exp<-NULL}

  #Generate MG lnks, ss
  if(nMG>0){
  MGvals<-rmvnorm(nMG,mean=MG.loc,sigma=MG.scale)
  lnk.MG.short<-MGvals[,1]
  
  s.MG.short<-apply(data.frame(MGvals[,2],rep(.1,length(MGvals[,2]))),1,max)
  lnk.MG<-rep(lnk.MG.short,each=n)
  s.MG<-rep(s.MG.short,each=n)
  }else{lnk.MG.short<-NULL        
        s.MG.short<-NULL
        lnk.MG<-NULL
        s.MG<-NULL}
  
  #Generate Rachlin lnks, ss
  if(nRachlin>0){
  Rachlinvals<-rmvnorm(nRachlin,mean=Rachlin.loc,sigma=Rachlin.scale)
  lnk.Rachlin.short<-Rachlinvals[,1]
  s.Rachlin.short<-apply(data.frame(Rachlinvals[,2],rep(.1,length(Rachlinvals[,2]))),1,max)
  lnk.Rachlin<-rep(lnk.Rachlin.short,each=n)
  s.Rachlin<-rep(s.Rachlin.short,each=n)
  }else{lnk.Rachlin.short<-NULL
        s.Rachlin.short<-NULL
        lnk.Rachlin<-NULL
        s.Rachlin<-NULL}
  
  #generate BD beta and delta 
  if(nBD>0){
    BD.beta.short<-runif(nBD,BD.betalow,BD.betahigh)
    BD.delta.short<-runif(nBD,BD.deltalow,BD.deltahigh)
    BD.beta<-rep(BD.beta.short,each=n)
    BD.delta<-rep(BD.delta.short,each=n)
  }else{BD.beta.short<-NULL
        BD.delta.short<-NULL
        BD.beta<-NULL
        BD.delta<-NULL}
  
  #Assuming common error variance across models generate residuals, X
  X<-rep(Xrun,N)

  #Generate nMazur sessions
  if(nMazur>0){
  X.Mazur<-rep(Xrun,nMazur)
  Yraw.Mazur<-(1+exp(lnk.Mazur)*X.Mazur)^-1 + rnorm((n*nMazur),0,sqrt(MSE)) #Mazur indifference points pre 0-1 censoring
  ED50.Mazur<-1/exp(lnk.Mazur.short) # Computes true ED50 for Mazur
  }else{Yraw.Mazur<-NULL
  X.Mazur<-NULL
  ED50.Mazur<-NULL}
  
  #Generate nexp 
  if(nexp>0){
  X.exp<-rep(Xrun,nexp) #sets up delays for Mazur
  Yraw.exp<-exp(-exp(lnk.exp)*X.exp) + rnorm((n*nexp),0,sqrt(MSE))
  ED50.exp<-log(2)/exp(lnk.exp.short)
  }else{Yraw.exp<-NULL
  X.exp<-NULL
  ED50.exp<-NULL}
  
  #Generate nMG 
  if(nMG>0){
  X.MG<-rep(Xrun,nMG)
  Yraw.MG<-(1+exp(lnk.MG)*X.MG)^(-s.MG) + rnorm((n*nMG),0,sqrt(MSE))
  ED50.MG<-(2^(1/s.MG.short) -1)/exp(lnk.MG.short)
  }else{Yraw.MG<-NULL
  X.MG<-NULL
  ED50.MG<-NULL}
  
  #Generate nRachlin sessions 
  if(nRachlin>0){
  X.Rachlin<-rep(Xrun,nRachlin)
  Yraw.Rachlin<-(1+exp(lnk.Rachlin)*X.Rachlin^s.Rachlin)^(-1) + rnorm((n*nRachlin),0,sqrt(MSE))
  ED50.Rachlin<-(1/exp(lnk.Rachlin.short))^(1/s.Rachlin.short)
  }else{Yraw.Rachlin<-NULL
  X.Rachlin=NULL
  ED50.Rachlin=NULL}
  
  #Generate nBD Quasi hyperbolic sessions
  if(nBD>0){
  X.BD<-rep(Xrun,nBD)
  Yraw.BD<- (BD.beta*(BD.delta^X.BD)) + rnorm((n*nBD),0,sqrt(MSE))
  ED50.BD<- log( 1/(2*BD.beta.short) ,BD.delta.short)
  }else{Yraw.BD<-NULL
  X.BD<-NULL
  ED50.BD<-NULL}
  
  ###Assemble data
  Yraw<-c(Yraw.Mazur,Yraw.exp,Yraw.MG,Yraw.Rachlin,Yraw.BD)
  Yfloor<-apply(cbind(Yraw,rep(0,length(Yraw))),1,max)
  Y<-apply(cbind(Yfloor,rep(1,length(Yraw))),1,min)
  
  
  #Return a list which includes true IDs, parameter values, true ED50s as element 1
  #Raw data, types, and sessions as element 2
  lnk<-   c(c(lnk.Mazur.short,lnk.exp.short,lnk.MG.short,lnk.Rachlin.short),rep(NA,nBD))
  s<-     c(rep(NA,(nMazur+nexp)),s.MG.short,s.Rachlin.short,rep(NA,nBD))
  beta<-c(  rep(NA,nMazur+nexp+nMG+nRachlin),BD.beta.short   )
  delta<-c(  rep(NA,nMazur+nexp+nMG+nRachlin),BD.delta.short   )
  
  ED50<-c(ED50.Mazur,ED50.exp,ED50.MG,ED50.Rachlin,ED50.BD)
  dat<-data.frame(ses=sort(rep(1:N,n)),X=X,Y=Y)
  parms<-data.frame(ses=1:N,lnk=lnk,s=s,beta=beta,delta=delta,ED50=ED50,ID=ID)
  return(list(parms,dat))  
}