#20.05.2022


#--------------------------------------------------------------------------------------------------#
library("dplyr")

rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#--------------------------------------------------------------------------------------------------# 
# global:
# Rang anys per generar dates index
data_inici='20060101'
data_final='20181231'
#--------------------------------------------------------------------------------------------------# 


#---------------------------- LECTURA -------------------------------------------------------------# 
#rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
#                  output_file=paste0(here::here("outputs/Informe_Lectura1_FinalDM2_Juny_"),Sys.Date()),
#                  params = list(dir_dades_desti=dir_dades_desti ,
#                                dir_dades_origen=dir_dades_origen,
#                                bd.dindex1=data_inici,
#                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 
#rm(list=ls())
#gc()
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
#if (mostra) {
#  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 
#rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
#                  output_file=paste0(here::here("outputs/Informe_Lectura2_FinalDM2_Juny_"),Sys.Date()),
#                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))
#--------------------------------------------------------------------------------------------------# 
#
#
#--------------------------------------------------------------------------------------------------# 
#rm(list=ls())
#gc()
#mostra=T
#dir_dades_desti="dades" 
#dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
#if (mostra) {
#  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
#  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 


rmarkdown::render(input="./codi/1_Gran_Funcio.Rmd",
                  output_file=paste0(here::here("outputs/Informe_GRAN_FUNCIO_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,dir_dades_origen=dir_dades_origen))

#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }

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


















