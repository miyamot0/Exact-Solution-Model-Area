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

####This file calls 'simulator' function
####Generates simulated data used in the study
####Workspace contains lists that store simulated data, true values of parameters

## Simulator function
source('simulator.R')

library(mvtnorm)
library(reshape)

T<-1 #Number of "studies", 1 study here; 
#N in Multifunct_sim is number of sessions, 10,000 in this study

#exponential sim
set.seed(83723)
for(t in 1:T){
  datstore<-Multifunct_sim(N=10000,pvect=c(0,1,0,0,0),mulnk.Mazur=NA,siglnk.Mazur=NA,
                           mulnk.exp=-7.065788,siglnk.exp=1.893938,
                           MG.loc,MG.scale=NA,Rachlin.loc=NA,Rachlin.scale=NA,
                           BD.betalow=NA,BD.betahigh=NA,BD.deltalow=NA,BD.deltahigh=NA,
                           MSE=.005)
}
indiff<-cast(data=datstore[[2]],formula=ses~X,value='Y')[,2:9]
row.names(indiff)<-NULL;names(indiff)<-NULL
outdat<-rbind(c(1,7,14,30,183,365,1825,9125),indiff) #export for csv

#Mazur simulation
set.seed(71239)
for(t in 1:T){
  datstore<-Multifunct_sim(N=10000,pvect=c(1,0,0,0,0),mulnk.Mazur=-6.34,siglnk.Mazur=1.72,
                           mulnk.exp=NA,siglnk.exp=NA,
                           MG.loc,MG.scale=NA,Rachlin.loc=NA,Rachlin.scale=NA,
                           BD.betalow=NA,BD.betahigh=NA,BD.deltalow=NA,BD.deltahigh=NA,
                           MSE=.005)
}
indiff<-cast(data=datstore[[2]],formula=ses~X,value='Y')[,2:9]
row.names(indiff)<-NULL;names(indiff)<-NULL
outdat<-rbind(c(1,7,14,30,183,365,1825,9125),indiff)

#MG simulation
set.seed(164928)
for(t in 1:T){
  datstore<-Multifunct_sim(N=10000,pvect=c(0,0,1,0,0),mulnk.Mazur=NA,siglnk.Mazur=NA,
                           mulnk.exp=NA,siglnk.exp=NA,
                           MG.loc=c(-4.622357,0.8786568),MG.scale=matrix(c(9.289053,-1.898686,-1.898686,1.121073),2,2),
                           Rachlin.loc=NA,Rachlin.scale=NA,
                           BD.betalow=NA,BD.betahigh=NA,BD.deltalow=NA,BD.deltahigh=NA,
                           MSE=.005)
}
indiff<-cast(data=datstore[[2]],formula=ses~X,value='Y')[,2:9]
row.names(indiff)<-NULL;names(indiff)<-NULL
outdat<-rbind(c(1,7,14,30,183,365,1825,9125),indiff)

#Rachlin simulation
set.seed(938342)
for(t in 1:T){
  datstore<-Multifunct_sim(N=10000,pvect=c(0,0,0,1,0),mulnk.Mazur=NA,siglnk.Mazur=NA,
                           mulnk.exp=NA,siglnk.exp=NA,
                           MG.loc,MG.scale=NA,
                           Rachlin.loc=c(-8.34,1.28),Rachlin.scale=matrix(c(53.98,-6.46,-6.46,0.943),2,2),
                           BD.betalow=NA,BD.betahigh=NA,BD.deltalow=NA,BD.deltahigh=NA,
                           MSE=.005)
}
indiff<-cast(data=datstore[[2]],formula=ses~X,value='Y')[,2:9]
row.names(indiff)<-NULL;names(indiff)<-NULL
outdat<-rbind(c(1,7,14,30,183,365,1825,9125),indiff)

#beta delta simulation
set.seed(62193)
for(t in 1:T){
  datstore<-Multifunct_sim(N=10000,pvect=c(0,0,0,0,1),mulnk.Mazur=NA,siglnk.Mazur=NA,
                           mulnk.exp=NA,siglnk.exp=NA,
                           MG.loc,MG.scale=NA,Rachlin.loc=NA,Rachlin.scale=NA,
                           BD.betalow=0.8111583,BD.betahigh=1,BD.deltalow=0.9556005,BD.deltahigh=0.9999929,
                           MSE=.005)
}
indiff<-cast(data=datstore[[2]],formula=ses~X,value='Y')[,2:9]
row.names(indiff)<-NULL;names(indiff)<-NULL
outdat<-rbind(c(1,7,14,30,183,365,1825,9125),indiff)