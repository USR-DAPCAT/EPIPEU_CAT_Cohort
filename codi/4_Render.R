#25.05.2022


#epiPEUCAT cohorte longitudinal retrospectiva, es coger casos DFD mirar el primer episodio y ver diferentes eventos


##::data_inici='20060101'
##::data_final='20181231'


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
rmarkdown::render(input="./codi/1_lectura.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura_Gran_Funcio_"),Sys.Date()),
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
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/2_preparacio.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti) )
#--------------------------------------------------------------------------------------------------# 


#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/3_analisis.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Analisi_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti) )
#--------------------------------------------------------------------------------------------------# 
































#--------------------------------------------------------------------------------------------------#
#[ANTIC]
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
rmarkdown::render(input="./codi/1_lectura_epipeu_PART1.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura1_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti ,
                                dir_dades_origen=dir_dades_origen,
                                bd.dindex1=data_inici,
                                bd.dindex2=data_final))
#--------------------------------------------------------------------------------------------------# 

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
rmarkdown::render(input="./codi/1_lectura_epipeu_PART2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Lectura2_"),Sys.Date()),
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
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/2_preparacio_epipeu_VER2.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Preparacio_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti) )
#--------------------------------------------------------------------------------------------------# 


#--------------------------------------------------------------------------------------------------# 
rm(list=ls())
gc()
mostra=T
dir_dades_desti="dades" 
dir_dades_origen="../DADES/EPIPEU_CAT3/dades" 
if (mostra) {
  dir_dades_origen="../../DADES/EPIPEU_CAT3/dades/mostra"
  dir_dades_desti="dades/mostra" }
#---------------------------- LECTURA -------------------------------------------------------------# 
rmarkdown::render(input="./codi/3_analisis.Rmd",
                  output_file=paste0(here::here("outputs/Informe_Analisi2_"),Sys.Date()),
                  params = list(dir_dades_desti=dir_dades_desti) )
#--------------------------------------------------------------------------------------------------# 






















