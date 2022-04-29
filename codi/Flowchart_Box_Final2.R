#----------------------------------------------------------------------------------------------#
#16.11.2020#
#----------------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------------#
#                       FLOW-CHART FINAL
#----------------------------------------------------------------------------------------------#

# Diagramer 

#https://cran.r-project.org/web/packages/Gmisc/vignettes/Grid-based_flowcharts.html
#https://rstudio-pubs-static.s3.amazonaws.com/213412_88e4454d1ab44cb2afed68fa832ad8c5.html#/11
#############
#rm(list=ls())
#############
# 12.11.2020 #
#############
#



Flowchart_Box_Final2<-function(
  
  grups=3,
  
  colors=c("white","red"),
  pob=10,
  pob_lab="Poblacio Total",
  
  pob1=c(2,1),
  pob2=c(3,1),
  pob3=c(5,3),
  
  exc1=c(1,0),
  exc2=c(1,1),
  exc3=c(1,1),
  
  exc_lab1=c("A :","B :"),
  exc_lab2=c("A :","B :"),
  exc_lab3=c("A :","B :"),
  
  pob_lab1=c("POB1_INICIAL","POB1_FINAL"),
  pob_lab2=c("POB2_INICIAL","POB2_FINAL"),
  pob_lab3=c("POB3:INICIAL","POB3_FINAL")
  
  )
  
  
{
  
  
  
  library(Rcpp)
  library(Gmisc)
  library(glue)
  library(htmlTable)
  library(grid)
  library(magrittr)
  
  
  
  ### Function 1 GROUP !
  
  Flowchart_Box_G1<-function(
    
    colors=c('white','grey'),
    pob=10000,
    pob_lab="POBLACIO a CATALUNYA",
    pob1=c(1000,50),
    pob_lab1=c("Pob inicial","Pob final"),
    exc1=c(18,12),
    exc_lab1=c('Edat>90 anys : ','Problemes Digestius : ')
    
    
    
  ) 
  
  
  {
    #---------------------------------------------------------------------------------------------------------------# 
    #colors=c('white','grey')
    #N=10000
    #N_LABEL="POBLACIO a CATALUNYA"
    #pob1=c(1000,50)
    #exc1=c(18,12)
    #exc_lab1=c('Edat>90 anys : ','Problemes Digestius : ')
    #pob_lab1=c("Pob inicial","Pob final"))
    #---------------------------------------------------------------------------------------------------------------# 
    
    grid.newpage()
    # set some parameters to use repeatedly
    leftx <- .25
    midx <- .5
    rightx <- .75
    width <- .4
    gp <- gpar(fill =colors)
    #
    #################################################################
    
    # create boxes TOTAL:
    TOTAL <- boxGrob(glue(pob_lab,"N = {pop}",pop = txtInt(pob),.sep = "\n"),x=midx, y=.9, box_gp = gp[2], width = 0.7)
    
    # create boxes GRUP1:
    
    if  (length(exc1)<1)
      
      #  
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc1)>=1 & length(exc1)<=10)
    {EXCLUDE<-paste0("Exclusions : ") %>%c(paste0(exc_lab1,":  ",exc1) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.7, y=.5, just = "left", box_gp = gp[1])}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup!")}
    
    GRUP1 <- boxGrob( glue(pob_lab1[1],"N = {pop}",pop = txtInt(pob1[1]),.sep = "\n"),x=midx, y=.7, box_gp = gp[2], width = 0.50)
    
    GRUP1_F <- boxGrob(glue(pob_lab1[2],"N = {pop}",pop = txtInt(pob1[2]),.sep = "\n"), x=midx, y=.3, box_gp = gp[2], width = 0.50)
    
    KK1<-connectGrob(TOTAL, GRUP1, "N")
    KK2<-connectGrob(GRUP1,GRUP1_F, "N")
    KK3<-connectGrob(GRUP1, EXCLUDE, "L")
    
    flow<- list(TOTAL,
                GRUP1,
                EXCLUDE,
                GRUP1_F,
                KK1,
                KK2,
                KK3)
    
    flow
    
  }
  
  
  ### Function 2 GROUPS !
  
  
  Flowchart_Box_G2<-function(
    
    colors=c("white","grey"),
    pob=10000,
    pob_lab="POBLACIO a CATALUNYA",
    
    pob1=c(100,50),
    pob2=c(200,60),
    
    exc1=c(18,12),
    exc2=c(56,90),
    
    exc_lab1=c("Si votes Vox :","<18 anys :"),
    exc_lab2=c("Si votes Colau :","<18 anys :"),
    
    pob_lab1=c("DIABETICS a CATALUNYA","DIABETICS a CATALUNYA FINAL"),
    pob_lab2=c("No DIABETICS a CATALUNYA","No DIABETICS a CATALUNYA FINAL")
    
    
  ) 
  
  
  
  {
    
    
    #---------------------------------------------------------------------------------------------------------------# 
    #colors=c("white","grey")
    #N=10000
    #N_LABEL="POBLACIO a CATALUNYA"
    #pob1=c(100,50)
    #pob2=c(200,60)
    #exc1=c(18,12)
    #exc2=c(56,90)
    #exc_lab1=c("Si votes Vox :","<18 anys :")
    #exc_lab2=c("Si votes Colau :","<18 anys :")
    #pob_lab1=c("DIABETICS a CATALUNYA","DIABETICS a CATALUNYA FINAL")
    #pob_lab2=c("No DIABETICS a CATALUNYA","No DIABETICS a CATALUNYA FINAL")
    #---------------------------------------------------------------------------------------------------------------# 
    
    
    grid.newpage()
    #---------------------------------------------------------------------------------------------------------------# 
    #
    # set some parameters to use repeatedly
    
    leftx <- .25
    midx <- .5
    rightx <- .75
    width <- .4
    gp <- gpar(fill =colors)
    
    #
    #---------------------------------------------------------------------------------------------------------------#
    
    # create boxes TOTAL:
    TOTAL <- boxGrob(glue(pob_lab,"N = {pop}",pop = txtInt(pob),.sep = "\n"),x=midx, y=.9, box_gp = gp[2], width = 0.5,txt_gp = gpar(cex = 0.8))
    
    
    # create boxes GRUP1:
    
    if  (length(exc1)<1)
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc1)>=1 & length(exc1)<=10)
      
    {exclude1<-paste0("Exclusions : ") %>%c(paste0(exc_lab1,":  ",exc1) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.3, y=.5, just = "left", box_gp = gp[1], width = 0.18,txt_gp = gpar(cex = 0.6) )}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup1!")}
    
    GRUP1 <- boxGrob( glue(pob_lab1[1],"N = {pop}",pop = txtInt(pob1[1]),.sep = "\n"),x=0.2, y=.7, just = "centre", box_gp = gp[2], width = 0.40
                      ,txt_gp = gpar(cex = 0.8))
    
    # create boxes GRUP2:
    
    if  (length(exc2)<1)
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc2)>=1 & length(exc2)<=10)
      
    {exclude2<-paste0("Exclusions : ") %>%c(paste0(exc_lab2," ",exc2) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.9, y=.5, just = "left", box_gp = gp[1], width = 0.18,
                                                txt_gp = gpar(cex = 0.6))}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup2!")}
    
    GRUP2 <- boxGrob( glue(pob_lab2[1],"N = {pop}",pop = txtInt(pob2[1]),.sep = "\n"),x=0.8, y=.7, just = "centre", box_gp = gp[2], width = 0.40
                      ,txt_gp = gpar(cex = 0.8))
    
    
    
    GRUP1_F <- boxGrob(glue(pob_lab1[2],"N = {pop}",pop = txtInt(pob1[2]),.sep = "\n"), x=0.2, y=.3, box_gp = gp[2], width = 0.40
                       ,txt_gp = gpar(cex = 0.8))
    GRUP2_F <- boxGrob(glue(pob_lab2[2],"N = {pop}",pop = txtInt(pob2[2]),.sep = "\n"), x=0.8, y=.3, box_gp = gp[2], width = 0.40
                       ,txt_gp = gpar(cex = 0.8))
    
    KK1<-connectGrob(TOTAL, GRUP1, "v")
    KK2<-connectGrob(TOTAL, GRUP2, "v")
    KK3<-connectGrob(GRUP1,GRUP1_F, "N")
    KK4<-connectGrob(GRUP2,GRUP2_F, "N")
    
    ###KK5<-connectGrob(GRUP1,exclude1, "N")
    ###KK6<-connectGrob(GRUP2,exclude2, "N")
    
    ###KK5,
    ###KK6
    
    flow<- list( TOTAL,
                 GRUP1,
                 GRUP2,
                 exclude1,
                 exclude2,
                 GRUP1_F,
                 GRUP2_F,
                 KK1,
                 KK2,
                 KK3,
                 KK4)
    
    flow
    
    
  }
  
  
  
  
  ### Function 3 GROUPS !
  
  
  Flowchart_Box_G3<-function(
    
    colors=c("white","grey"),
    pob=10000,
    pob_lab="POBLACIO a CATALUNYA",
    
    pob1=c(100,50),
    pob2=c(200,60),
    pob3=c(300,40),
    
    exc1=c(18,12),
    exc2=c(56,90),
    exc3=c(13,31),
    
    exc_lab1=c("Si votes Vox :","<18 anys :"),
    exc_lab2=c("Si votes Colau :","<200 anys :"),
    exc_lab3=c("Si votes Valls :","<32 anys :"),
    
    pob_lab1=c("DIABETICS a CATALUNYA","DIABETICS a CATALUNYA FINAL"),
    pob_lab2=c("No DIABETICS a CATALUNYA","No DIABETICS a CATALUNYA FINAL"),
    pob_lab3=c("Capullos a CATALUNYA","Capullos a CATALUNYA FINAL")
  ) 
  
  {
    
    
    #colors=c("white","grey")
    #N=10000
    #N_LABEL="POBLACIO a CATALUNYA"
    
    #pob1=c(100,50)
    #pob2=c(200,60)
    #pob3=c(300,40)
    
    #exc1=c(18,12)
    #exc2=c(56,90)
    #3=c(exc13,31)
    
    #exc_lab1=c("Si votes Vox :","<18 anys :")
    #exc_lab2=c("Si votes Colau :","<200 anys :")
    #exc_lab3=c("Si votes Valls :","<32 anys :")
    
    #pob_lab1=c("DIABETICS a CATALUNYA","DIABETICS a CATALUNYA FINAL")
    #pob_lab2=c("No DIABETICS a CATALUNYA","No DIABETICS a CATALUNYA FINAL")
    #pob_lab3=c("Capullos a CATALUNYA","Capullos a CATALUNYA FINAL")
    
    
    grid.newpage()
    #---------------------------------------------------------------------------------------------------------------# 
    #
    # set some parameters to use repeatedly
    leftx <- .25
    midx <- .5
    rightx <- .75
    width <- .4
    gp <- gpar(fill =colors)
    #
    #---------------------------------------------------------------------------------------------------------------#
    
    
    # create boxes TOTAL:
    TOTAL <- boxGrob(glue(pob_lab,"N = {pop}",pop = txtInt(pob),.sep = "\n"),x=midx, y=.9, box_gp = gp[2], width = width)
    
    # create boxes GRUP1:
    
    if  (length(exc1)<1)
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc1)>=1 & length(exc1)<=10)
    {exclude1<-paste0("Exclusions :") %>%c(paste0(exc_lab1,":  ",exc1) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.35, y=.5, just = "left")}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup1!")}
    
    GRUP1 <- boxGrob( glue(pob_lab1[1],"N = {pop}",pop = txtInt(pob1[1]),.sep = "\n"), x=leftx, y=.7, just = "centre", box_gp = gp, width = 0.22)
    
    # create boxes GRUP2:
    
    if  (length(exc2)<1)
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc2)>=1 & length(exc2)<=10)
    {exclude2<-paste0("Exclusions :") %>%c(paste0(exc_lab2," ",exc2) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.6, y=.5, just = "left")}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup2!")}
    
    GRUP2 <- boxGrob( glue(pob_lab2[1],"N = {pop}",pop = txtInt(pob2[1]),.sep = "\n"),x=0.5, y=.7, just = "centre", box_gp = gp, width = 0.22)
    
    # create boxes GRUP3
    
    if  (length(exc3)<1)
    {print("Error, posa els GRUPS, si us plau! al Flowchart!")}else if(length(exc3)>=1 & length(exc3)<=10)
    {exclude3<-paste0("Exclusions :") %>%c(paste0(exc_lab3," ",exc3) %>% paste0()) %>%
      paste0(collapse = "\n") %>%Gmisc::boxGrob(x=0.85, y=.5, just = "left")}else
      {print("ERROR!, Les Exlusions han de ser iguals o inferiors a 10 al grup2!")}
    
    GRUP3 <- boxGrob( glue(pob_lab3[1],"N = {pop}",pop = txtInt(pob3[1]),.sep = "\n"), x=rightx, y=.7, just = "centre", box_gp = gp, width = 0.22)
    
    
    
    GRUP1_F <- boxGrob(glue(pob_lab1[2],"N = {pop}",pop = txtInt(pob1[2]),.sep = "\n"), x=leftx, y=.3, box_gp = gp[2], width = 0.22)
    GRUP2_F <- boxGrob(glue(pob_lab2[2],"N = {pop}",pop = txtInt(pob2[2]),.sep = "\n"), x=0.5, y=.3, box_gp = gp[2], width = 0.22)
    GRUP3_F <- boxGrob(glue(pob_lab3[2],"N = {pop}",pop = txtInt(pob3[2]),.sep = "\n"),  x=rightx, y=.3, box_gp = gp[2], width = 0.22)
    
    KK1<-connectGrob(TOTAL, GRUP1, "v")
    KK2<-connectGrob(TOTAL, GRUP2, "v")
    KK3<-connectGrob(TOTAL, GRUP3, "v")
    KK4<-connectGrob(GRUP1,GRUP1_F, "N")
    KK5<-connectGrob(GRUP2,GRUP2_F, "N")
    KK6<-connectGrob(GRUP3,GRUP3_F, "N")
    
    KK7<-connectGrob(GRUP1,exclude1, "L")
    KK8<-connectGrob(GRUP2,exclude2, "L")
    KK9<-connectGrob(GRUP3,exclude3, "L")
    
    flow<- list( TOTAL,
                 GRUP1,
                 GRUP2,
                 GRUP3,
                 exclude1,
                 exclude2,
                 exclude3,
                 GRUP1_F,
                 GRUP2_F,
                 GRUP3_F,
                 KK1,
                 KK2,
                 KK3,
                 KK4,
                 KK5,
                 KK6,
                 KK7,
                 KK8,
                 KK9
                 
                 
                 
    )
    
    flow
    
    
  }
  
  
  ############## Choose the group, please!
  
  
  
  if  (grups<1)
  {print("Error, posa els GRUPS, si us plau! al Flowchart!")  }
  else if  (grups==1)
    
  {Flowchart_Box_G1(
    colors=colors,
    pob=pob,
    pob_lab=pob_lab,
    pob1=pob1,
    exc1=exc1,
    exc_lab1=exc_lab1,
    pob_lab1=pob_lab1)
    
    #colors=c('white','grey'),
    #N=10000,
    #N_LABEL="POBLACIO a CATALUNYA",
    #pob1=c(1000,50),
    #pob_lab1=c("Pob inicial","Pob final"),
    #exc1=c(18,12),
    #exc_lab1=c('Edat>90 anys : ','Problemes Digestius : '
    
    
     
    }
  
  else if (grups==2)
  {Flowchart_Box_G2(
    colors=colors,
    pob=pob,
    pob_lab=pob_lab,
    
    pob1=pob1,
    pob2=pob2,
    
    
    exc1=exc1,
    exc2=exc2,
    
    
    exc_lab1=exc_lab1,
    exc_lab2=exc_lab2,
    
    
    pob_lab1=pob_lab1,
    pob_lab2=pob_lab2
    
    
    
     ) }
  
  else if (grups==3)
  {Flowchart_Box_G3(
    colors=colors,
    pob=pob,
    pob_lab=pob_lab,
    
    pob1=pob1,
    pob2=pob2,
    pob3=pob3,
    
    exc1=exc1,
    exc2=exc2,
    exc3=exc3,
    
    exc_lab1=exc_lab1,
    exc_lab2=exc_lab2,
    exc_lab3=exc_lab3,
    
    pob_lab1=pob_lab1,
    pob_lab2=pob_lab2,
    pob_lab3=pob_lab3
      ) }
  else if (grups>3)
  {
    print("Error no podem fer més de 3 Grups pel Flowchart!")
  }
}




