#By Ray!
#13.11.2020

criteris_exclusio_diagrama2<-function(dt=dades,
                                      taulavariables="VARIABLES_R3b.xls",
                                      criteris="exclusio1",
                                      POB=100000,
                                      POB_LAB="Baix Camp",
                                      pob_lab=c("Pob inicial","Pob final"),
                                      etiquetes="etiqueta_exclusio",
                                      ordre="exc_ordre",
                                      grups=NA,
                                      sequencial=F,
                                      colors=c("white","grey"), missings=T){
  
  
  
  
#  dt=dt_plana
#  taulavariables=conductor
#  criteris = "exc_pre"
#  ordre="exc_ordre"
#  grups=NA
#  etiquetes="descripcio"
#  sequencial = T
#  pob_lab=c("epiPEUCAT DM2  ","epiPEUCAT DM2 sin exclusiones")
#  colors=c("white","grey")
  
#  POB=100000
#  POB_LAB="Baix Camp"
  
  
  
  grups2=grups
  ### Si hi ha grups capturar el nombre categories
  # Per defecte UN sol grup
  ngrups=1
  # ngrups>1
  if (!is.na(grups)) {
    ngrups=length(table(dt[grups]))
    Etiqueta_pob_inicial=pob_lab[1]
    Npob_inicial=dt %>% count() %>% as.numeric()}
  
  ##  Llegeixo criteris de variables i selecciono variables amb filtres 
  variables <- readxl::read_excel(taulavariables,col_types = "text") %>% tidyr::as_tibble() %>% dplyr::select(camp,!!etiquetes,!!ordre,!!criteris)
  
  # Filtrar valors
  criteris_sym<-sym(criteris)
  variables<-variables %>% dplyr::filter(!is.na(!!criteris_sym))
  # variables[is.na(variables)]<- 0
  # variables<-variables %>% dplyr::filter_(paste0(criteris,"!=0")) 
  
  # Parar si no hi ha criteris d'exclusiÃ³
  if (variables %>% count() %>% as.numeric()==0) {
    print("No hi ha criteris jejejj")
    return("Error") }
  
  ##  Elimino els espais en blanc de les variables factor
  dt<-dt %>% dplyr::mutate_if(is.factor,funs(str_trim(.))) 
  
  ## Selecciono dades nomÃ©s de les variables implicades en el filtres 
  #llista_camps<-variables["camp"] 
  
  ## Dades amb variables implicades en els filtres
  if (is.na(grups)) {dt<-dt %>% dplyr::mutate(grup="constant")}  
  if (is.na(grups)) {grups="grup"}
  
  datatemp0<-dt %>% dplyr::select(c(variables[["camp"]],grups)) %>% as_tibble %>% rename_("grup"=grups)
  datatemp<-dt %>% dplyr::select(c(variables[["camp"]],grups)) %>% as_tibble %>% rename_("grup"=grups)
  
  datatemp0<-datatemp0 %>% dplyr::filter(!is.na(grup))
  datatemp<-datatemp %>% dplyr::filter(!is.na(grup))
  
  # Genero filtres
  maco_noms<-variables["camp"]
  
  # Genero la llista de filtres 
  # maco_criteris<-variables %>% 
  #   dplyr::select_("camp",criteris,ordre) %>%
  #   tidyr::unite_("filtres", c("camp", criteris),sep="") 
  
  # Genero la llista de filtres (versiÃ³ millorada) 
  
  # caracters logics del filtre
  char_logics<-c(">",">=","<","<=","==","!=","is.na") %>% paste0(collapse = '|')
  
  maco_criteris<-variables %>% 
    dplyr::filter_(paste0(criteris,"!=0")) %>% dplyr::select_("camp",criteris,ordre) %>% 
    transmute_("camp","crit_temp"=criteris,ordre) %>% 
    # if criteri missing is.na()
    mutate(crit_temp=if_else(str_detect(crit_temp,"is.na"),paste0("is.na(",camp,")"),crit_temp)) %>% 
    mutate(camp=if_else(str_detect(crit_temp,"is.na"),"",camp)) %>% 
    # Si es texte sense igualtat --> la poso 
    mutate(crit_temp=if_else(str_detect(crit_temp,char_logics),crit_temp,paste0("=='",crit_temp,"'"))) %>% 
    # Genero la llista de filtres 
    tidyr::unite(filtres, c("camp", "crit_temp"),sep="") %>% 
    mutate(filtres=paste0("(",filtres,")"))
  
  maco_criteris<-maco_noms %>% cbind(maco_criteris) %>%dplyr::mutate(tipus_cri="pur")
  
  # Afegeix que cada criteri tingui valors valids en cada criteri  
  maco_criteris<-maco_criteris %>% mutate(filtres=stringr::str_c("(",filtres, " & !is.na(",camp, "))"))   
  
  maco_miss<-variables %>% 
    dplyr::select_("camp",ordre) %>%
    dplyr::mutate(filtres=paste0("is.na(",OR2=camp,")",sep="")) %>% dplyr::select_("filtres",ordre)
  
  maco_miss<-maco_noms %>% cbind(maco_miss) %>% dplyr::mutate(tipus_cri="missing")
  
  maco_criteris<-maco_criteris %>% rbind(maco_miss) %>%dplyr::arrange_(ordre)
  
  # # Eliminar filtres repetits?
  maco_criteris<-maco_criteris %>% group_by(filtres) %>% slice(1L) %>% ungroup() %>% arrange_(ordre)
  
  ## Eliminar missings criteri si missings==F                                                        
  if (missings==F) maco_criteris<-maco_criteris %>% filter(tipus_cri!="missing")  
  
  
  ## Generar taula amb dades per cada criteri d'exclusiÃ³  
  num_criteris<-data.frame()
  
  ## Generar dades dels critersi criteris 
  datatemp2<-datatemp
  
  for (i in 1: length(maco_criteris$filtres)){
    
    #i<-3
    kk<-maco_criteris[i,]$filtres
    datatemp2<-datatemp2 %>%dplyr::mutate(dumy=(if_else(eval(parse(text=kk)),1,0,missing =NULL)),
                                          dumy = replace_na(dumy, 0))
    
    dades_criteris<-datatemp2 %>% 
      dplyr::filter_(as.character(maco_criteris[i,]$filtres)) %>% 
      dplyr::group_by(grup) %>% summarise (n=n(),any(n)) %>% mutate(criteri=i) %>% 
      dplyr::mutate(camp=maco_criteris[i,]$camp,
                    filtre_tipus=maco_criteris[i,]$tipus_cri,
                    filtre_forma=maco_criteris[i,]$filtres
      ) %>% 
      ungroup
    
    num_criteris<-num_criteris %>% rbind(dades_criteris)
    #------------------------------------------------------------------------------#  
    #  # Si es sequencial --> actualitza datatemp
    if (sequencial) {datatemp2<-datatemp2 %>%dplyr::filter(dumy==0)}
    
    #-------------------------------------------------------------------------------#  
    
  }
  
  # Si un grup no te exclusions s'ha d'afegir una fila missing 
  nivells_grup<-datatemp %>% dplyr::select(grup) %>% distinct() %>% pull()
  
  num_criteris<-num_criteris %>% bind_rows(tibble(grup=nivells_grup[1]))
  num_criteris<-num_criteris %>% bind_rows(tibble(grup=nivells_grup[2]))
  num_criteris<-num_criteris %>% bind_rows(tibble(grup=nivells_grup[3]))
  
  # ull FEM l'ODRE !!!
  
  # Expandir per tenir una fila per criteri amb valor 
  taula_criteris<-num_criteris %>% 
    expand(grup,camp,filtre_tipus) %>% 
    dplyr::left_join(num_criteris,by=c("grup","camp","filtre_tipus"))%>%dplyr::arrange_("criteri")
  
  # Netejar aquelles files que no tinguin cap 0 en cap dels grups 
  temp<-taula_criteris %>% mutate(n=ifelse(is.na(n),0,n)) %>% 
    dplyr::group_by(camp,filtre_tipus) %>% 
    dplyr::summarise(suma_n=sum(n))
  
  taula_criteris<-taula_criteris %>% 
    dplyr::left_join(temp,by=c("camp","filtre_tipus")) %>% 
    dplyr::filter(suma_n!=0) %>% 
    dplyr::select(-suma_n) %>% 
    dplyr::mutate (n=ifelse(is.na(n),0,n))
  
  # Afegir ordre
  taula_ordre<-taula_criteris %>% group_by(camp) %>% slice(1L) %>% ungroup() %>% select(camp,ordre=criteri)
  taula_criteris<-taula_criteris %>% left_join(taula_ordre,by="camp") %>% arrange(ordre)
  
  # Afegir etiquetes a num_criteris
  # Etiquetes dels criteris d'inclusio 
  
  if (etiquetes=="NA") {
    variables<-variables %>% dplyr::mutate(etiquetes=paste0(camp,":",variables[[criteris]]))
    variables<-variables %>% dplyr::mutate(etiquetes=stringr::str_remove_all(etiquetes,"'"))}
  
  etiquetes_sym=rlang::sym(etiquetes)
  if (etiquetes!="NA") {variables<-variables %>%dplyr:: mutate(etiquetes=!!etiquetes_sym)}
  
  taula_etiquetes<- variables %>%dplyr::select(camp,etiquetes) %>%dplyr:: rename(etiqueta_exclusio=etiquetes)
  #taula_etiquetes<- variables %>% dplyr::select_("camp",etiquetes) %>%dplyr:: rename_("etiqueta_exclusio"=etiquetes)
  taula_criteris<-taula_criteris %>% dplyr::left_join(taula_etiquetes,by="camp")
  taula_criteris<-taula_criteris %>% dplyr::mutate(etiqueta_exclusio=ifelse(filtre_tipus=="missing",paste0("Excluded NA:",camp),etiqueta_exclusio))
  
  #[AQUI!]#Creem els parametres que posramen ald Diagrammer!i si tenim un factor, 
  #cada nivell del factor anira a una llista! 
  ## I ara passar informaciÃ³ generada a vectors per passar-ho al diagrameR
  
  # Etiquetes d'exclusions
  lab_exc<-taula_criteris[c("etiqueta_exclusio","grup")] %>% split(.$grup)
  lab_exc<-lab_exc[[1]]$etiqueta_exclusio %>% as_vector
  
  # N d'esclusions 
  n_exc<-taula_criteris[c("n","grup")] %>% split(.$grup)
  
  # Calcular N poblaciÃ³ final per cada grup (3x1)
  # Generar FILTRE
  filtre_total<-stringr::str_c(maco_criteris$filtres,collapse=" | ")
  filtre_total<-stringr::str_c("!(",filtre_total,")")
  
  # Eliminar els espais en blanc de les variables factors del data.frame
  datatemp<-datatemp %>% dplyr::mutate_if(is.factor,funs(str_trim(.)))
  
  # Aplicar FILTRE 
  datatemp<-datatemp %>% dplyr::filter(eval(parse(text=filtre_total)))
  
  
  #  Generar Etiquetes: Pob inicial i final x grup 
  #-------------------------------------------------------------------------------#
  pob<-datatemp0%>% dplyr::summarise (n=n()) %>% dplyr::select(n) %>% as.vector
  
  
  pob.i<-datatemp0 %>%dplyr:: group_by(grup) %>% dplyr::summarise (n=n()) %>% dplyr::select(n) %>% as.vector
  pob.f<-datatemp %>% dplyr::group_by(grup) %>% dplyr::summarise (n=n()) %>% dplyr::select(n) %>% as.vector
  #-------------------------------------------------------------------------------#
  
  n_pob1<-c(pob.i$n[1],pob.f$n[1])
  n_pob2<-c(pob.i$n[2],pob.f$n[2])
  n_pob3<-c(pob.i$n[3],pob.f$n[3])
  
  ###################################################################
  #  Generar Etiquetes: Pob inicial i final x grup 
  #  Etiquetes grups
  
  pob_lab_grup1<-c(paste0("Group Pob.Inicial  ",grups2,    ":  ",names(n_exc)[1]),paste0("Group Pob.Final  ",grups2,": ",names(n_exc)[1]))
  pob_lab_grup2<-c(paste0("Group Pob.Inicial  ",grups2,     ": ",names(n_exc)[2]),paste0("Group Pob.Final  ",grups2,": ",names(n_exc)[2]))
  pob_lab_grup3<-c(paste0("Group Pob.Inicial  ",grups2,     ": ",names(n_exc)[3]),paste0("Group Pob.Final  ",grups2,": ",names(n_exc)[3]))
  
  
  # Si nomÃ©s hi ha un grup pob inicial es parametres inicials
  #-------------------------------------------------------------------------------#
  if ( ngrups==1) {
    pob_lab_grup1<-pob_lab
    pob_lab_grup2<-pob_lab
    pob_lab_grup3<-pob_lab
    exc1=n_exc[[1]]$n %>%as_vector
    exc_lab1=lab_exc
    pob1=n_pob1
    pob_lab1=pob_lab_grup1
  }
  #-------------------------------------------------------------------------------#  
  if ( ngrups==2) {
    pob=Npob_inicial
    pob_lab=Etiqueta_pob_inicial
    exc1=n_exc[[1]]$n %>%as_vector
    exc2=n_exc[[2]]$n %>%as_vector
    exc_lab1=lab_exc
    exc_lab2=lab_exc
    pob1=n_pob1
    pob2=n_pob2
    pob_lab1=pob_lab_grup1
    pob_lab2=pob_lab_grup2
  }
  #-------------------------------------------------------------------------------#
  if ( ngrups==3) {
    pob=Npob_inicial
    pob_lab=Etiqueta_pob_inicial
    exc1=n_exc[[1]]$n %>%as_vector
    exc2=n_exc[[2]]$n %>%as_vector
    exc3=n_exc[[3]]$n %>%as_vector
    exc_lab1=lab_exc
    exc_lab2=lab_exc
    exc_lab3=lab_exc
    pob1=n_pob1
    pob2=n_pob2
    pob3=n_pob3
    pob_lab1=pob_lab_grup1
    pob_lab2=pob_lab_grup2
    pob_lab3=pob_lab_grup3
  }
  #-------------------------------------------------------------------------------# 
  
 
 
  
  # Crido diagrama 
  
  
####################################################################################  
# flow_chart1<-criteris_exclusio_diagrama(dt=dt_plana,
#                                          taulavariables=conductor,
#                                          criteris = "exc_pre",
#                                          ordre="exc_ordre",
#                                          grups=NA,
#                                          etiquetes="descripcio",
#                                          sequencial = T,
#                                          pob_lab=c("epiPEUCAT DM2  ","epiPEUCAT DM2 sin exclusiones"),
#                                          colors=c("white","grey"),
#                                          forma=c("ellipse","box"))
#  
#################################################################################### 
# Flow_Final_prova1<-Flowchart_Box_Final(
#    
#    grups=1,
#    colors=c('white','grey'),
#    pob=10000,
#    pob_lab = "POBLACIO de Tarragona",
#    pob1=c(1000,50),
#    pob_lab1=c("Pob inicial","Pob final"),
#    exc1=c(18,12),
#    exc_lab1=c('Edat>90 anys : ','Problemes Digestius : ')
#  )
####################################################################################
    
  
  
  
  
  #pob_lab/parametre!!
  
  
 
  
  
  
  diagrama<-Flowchart_Box_Final2(grups=ngrups ,
                                pob=POB,
                                pob_lab=POB_LAB,
                                
                                pob1=pob1,
                                pob2=pob2,
                                pob3=pob3,
                                
                                pob_lab1=pob_lab1,
                                pob_lab2=pob_lab2,
                                pob_lab3=pob_lab3,
                                
                                exc1=exc1,
                                exc2=exc2,
                                exc3=exc3,
                                
                                exc_lab1=exc_lab1,
                                exc_lab2=exc_lab2,
                                exc_lab3=exc_lab3,
                                
                                colors=colors
                                
                                
  )
  
  
  diagrama
  
  
  ################################################################################################
  #
  #  dt=dt_plana
  #  taulavariables=conductor
  #  criteris = "exc_pre"
  #  ordre="exc_ordre"
  #  grups=NA
  #  etiquetes="descripcio"
  #  sequencial = T
  #  pob_lab=c("epiPEUCAT DM2  ","epiPEUCAT DM2 sin exclusiones")
  #  colors=c("white","grey")
  
  #  POB=100000000000
  #  POB_LAB="HELSINKY"
  
  #
  #
  ################################################################################################
  
  
  
  
  
  #flow_chart2<-criteris_exclusio_diagrama2(dt=dt_plana,
  #                                         taulavariables=conductor,
  #                                         criteris = "exc_pre",
  #                                         ordre="exc_ordre",
  #                                         grups=NA,
  #                                         etiquetes="descripcio",
  #                                         sequencial = T,
  #                                         pob_lab=c("epiPEUCAT DM2  ","epiPEUCAT DM2 sin exclusiones"),
  #                                         colors=c("white","grey"),
  #                                         POB=100000000000,
  #                                         POB_LAB="OSLO")
  ####################################################################################################
  
  
}




