#06.04.2022#

############
#22.07.2021#
#22.02.2022#
############

#bona nit: he estat continuant fent les taules i figures 
#i he trobat molt estrany que el mal  control de la PA >=140/90 estigui sempre per sota del 8% i al final del seguiment al voltant del 3%.
#Les dades no s'asemblen res a les de la meva tesi que anaven del 60 al 75% (que es lo esperable)... mireu la gràfica de la meva tesi:


#A més la distribució de la PA fa que la major part dels nostres pacients (57,6%) estiguin per sota de PAS <120, 
#el que pot arribar a ser perillós pel risc d'hipotensió i caigudes.. 
#La pregunta 
#Aes: com es va calcular (la mitjana de totes les determinacions de l'any,
#la mitjana dels tres ultims valors tal com varem fer en el econtrol de 2009? o la meva tesi?
#Potser el més important es conèixer com s'ha fet per mirar d'esbrinar on pot estar l'err.
#
#
#
#
#
#




#Models qu? s'han de fer:07.06.2021



#M.i[ajuste13]
#
#Edad                                                       [01]
#Sexo1: 2. Hombre                                           [02]
#Tiempo de Evolucion Categorizado (Anos): >=5               [03]
#tabac21. Riesgo Elevado  ref: no smokers                   [04]
#Complicaciones macro vasculares                            [05]
#Complicaciones micro vasculares                            [06]    
#Hipertension                                               [07]
#Dislipemia                                                 [08]
#Antecedentes de ulceras/pie diab?                          [09]NO!!  
#DG.AMPUTACIO_Ext_inferiorSi                                [10]
#DG.IQ_ARTSi                                                [11]
#DG.INF_PIEL_MEM_INFSi                                      [12]


#M.ii[ajuste14]
#
#Edad                                                       [01] 
#Sexo1: 2. Hombre                                           [02]
#tabac21. Riesgo Elevado  ref: no smokers                   [03]
#Complicaciones macro vasculares                            [04]
#DG.NEUROPTSi                                               [05]
#DG.RTP_DMSi                                                [06]
#DG.INS_RNCSi                                               [07]
#Hipertension                                               [08]
#Dislipemia                                                 [09]
#Antecedentes de ulceras/pie diab?                          [10]NO!!
#DG.AMPUTACIO_Ext_inferiorSi                                [11]
#DG.IQ_ARTSi                                                [12]
#DG.INF_PIEL_MEM_INFSi                                      [13]


#M.iii[ajuste15]
#
#Edad                                                       [01]
#Sexo1: 2. Hombre                                           [02]
#tabac21. Riesgo Elevado  ref: no smokers                   [03]
#DG.ARTPER2Si                                               [04]
#DG.AVCSi                                                   [05]
#DG.ICSi                                                    [06]
#DG.CISi                                                    [07]
#DG.NEUROPTSi                                               [08]
#DG.RTP_DMSi                                                [09]
#DG.INS_RNCSi                                               [10]
#Hipertension                                               [11]
#Dislipemia                                                 [12]
#Antecedentes de ulceras/pie diab?                          [13]NO!!
#DG.AMPUTACIO_Ext_inferiorSi                                [14]
#DG.IQ_ARTSi                                                [15]
#DG.INF_PIEL_MEM_INFSi                                      [16]



#M.iv[ajuste16]
#
#Edad                                                       [01]
#Sexo1: 2. Hombre                                           [02]
#tabac21. Riesgo Elevado  ref: no smokers                   [03]
#FF.BiguanidasSi                                            [04]  
#FF.SulfonilureasSi                                         [05]  
#FF.GlinidesSi                                              [06]
#FF.TiazolidinadionesSi                                     [07]x
#FF.ISGLT2Si                                                [08]  
#FF.IDPP4Si                                                 [09]
#FF.OtrAntidiabOralesSi                                     [10]x
#FF.InAlfaGlucSi                                            [11]x
#FF.aGLP1Si                                                 [12]
#FF.InsulSi                                                 [13]



#M.v[ajuste17]
#
#Edad                                                       [01] 
#Sexo1: 2. Hombre                                           [02]  
#tabac21. Riesgo Elevado  ref: no smokers                   [03]
#FF.NiadSi                                                  [04]
#FF.InsulSi                                                 [05]
#FF.Hipotensores_ANTICASi                                   [06]
#FF.Hipotensores_ARASi                                      [07]
#FF.Hipotensores_BBKSi                                      [08]
#FF.Hipotensores_IECASi                                     [09]
#FF.Hipotensores_DIUSi                                      [10]  
#FF.Hipotensores_altresSi                                   [11]
#FF.C10Si                                                   [12]
#FF.Hipolipemiantes_ESTASi                                  [13]
#FF.Hipolipemiantes_FIBSi                                   [14]
#FF.Hipolipemiantes_EZESi                                   [15]x
#FF.Hipolipemiantes_altresSi                                [16]x



#--------------------------------------------------------------------------------------------------#
#O
#--------------------------------------------------------------------------------------------------#
library("dplyr")

rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20181231'
data_final='20181231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20181231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2018"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final3_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#























#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")

rm(list=ls())
gc()
mostra=F
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20181231'
data_final='20181231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=F
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=F
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20181231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2018"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_POB_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_POB_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final3_POB_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu4.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final4_POB_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#














#
#
#


#ray!!

#--------------------------------------------------------------------------------------------------#
#Ib
#--------------------------------------------------------------------------------------------------#
library("dplyr")

rm(list=ls())
gc()

#--------------------------------------------------------------------------------------------------# 
# rai:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20181231'
data_final='20181231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()

#--------------------------------------------------------------------------------------------------# 
# rai:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()

#--------------------------------------------------------------------------------------------------# 
# rai:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20181231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2018"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final3_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu4.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final4_MOST_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#










#2017
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20171231'
data_final='20171231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20171231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2017"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#


















#2016
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20161231'
data_final='20161231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20161231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2016"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#





#2015
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20151231'
data_final='20151231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20151231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2015"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#













#2014
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20141231'
data_final='20141231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20141231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2014"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#







#EPS , ho estem mirant:

#2013 s' ha de canviar AJUST6, hi han variables que no existeixen!!
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20131231'
data_final='20131231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20131231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="N",ANY=ANY))



ANY="2013"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))

#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#















#FINS AQUI:[]








#2012
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20121231'
data_final='20121231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20121231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2012"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#






#2011
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20111231'
data_final='20111231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20111231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2011"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#







#2010
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20101231'
data_final='20101231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1B.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20101231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2010"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#






#2009
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20091231'
data_final='20091231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1B.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20091231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2009"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu3.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#



#2008
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20081231'
data_final='20081231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1B.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 



ANY="20081231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2008"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu4.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#









#2007
###################################################################################################
#[04.06.2021]
####################################################################################################
#--------------------------------------------------------------------------------------------------#
#I
#--------------------------------------------------------------------------------------------------#
library("dplyr")
rm(list=ls())
#
#jordi:
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 

if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20071231'
data_final='20071231'
#--------------------------------------------------------------------------------------------------# 
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1B.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
#
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="/../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="/../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# rai:
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../../DADES/EPIPEU_CAT3/dades" 

#if (mostra) {dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 


ANY="20071231"
#---------------------------  PREPARACIO ----------------------------------------------------------#
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_FinalDM2_Juny_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,Param="Y",ANY=ANY))



ANY="2007"
#---------------------------   ANALISIS -----------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti,ANY=ANY))
#---------------------------------------------------------------------------------------------------#
rmarkdown::render(input="./codi/3_analisis_epipeu5.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Exploratori_Final2_"),ANY,"_",Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti))
#---------------------------------------------------------------------------------------------------#
