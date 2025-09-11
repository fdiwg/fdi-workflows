#Workflow for ASFIS-related FDI resources
#Pulls the latest ASFIS and create a CSV file for fdi-codelists
#Produces mapping with WoRMS and create a CSV file for fdi-mappings
#Produces a derived codelist containing ASFIS code and all record information from WoRMS as CSV file for fdi-codelists

#packages 
require(fdi4R)
require(worrms)

#produce_cl_asfis_species
produce_cl_asfis_species <- function(){
  
  link<-'https://www.fao.org/fishery/static/ASFIS/ASFIS_sp.zip'
  
  path<-file.path(tempdir(),"ASFIS_sp.zip")
  unziped<-gsub(".zip","",path)
  download.file(url = link, destfile = path)
  utils::unzip(zipfile = path, exdir = unziped, unzip = getOption("unzip"))
  
  folder_file<-list.files(unziped,full.names = T)
  
  match<-folder_file[grepl('*.csv', folder_file)]
  
  data<-readr::read_csv(match)
  
  reformat<-data.frame(code=data$Alpha3_Code,
                       uri=rep("",nrow(data)),
                       label=data$English_name,
                       definition=data$Scientific_Name,
                       name_en=data$English_name,
                       name_fr=data$French_name,
                       name_es=data$Spanish_name,
                       name_ar=data$Arabic_name,
                       name_cn=data$Chinese_name,
                       name_ru=data$Russian_name,
                       isscaap_group_code=data$ISSCAAP_Group,
                       taxon_scientific_name=data$Scientific_Name,
                       taxon_code=data$Taxonomic_Code,
                       taxon_author=data$Author,
                       taxon_family=data$Family,
                       taxon_order=data$`Order or higher taxa`)
  
  reformat[is.na(reformat)] <- ""
  return(reformat)
}

#1- ASFIS species list update
asfis_reformatted = produce_cl_asfis_species()
readr::write_csv(asfis_reformatted, "../fdi-codelists/global/cwp/cl_asfis_species.csv")

#2- ASFIS-WoRMS mapping
asfis = readr::read_csv("https://raw.githubusercontent.com/fdiwg/fdi-codelists/refs/heads/main/global/cwp/cl_asfis_species.csv")
asfis$AphiaID = unlist(fdi4R::get_WoRMS_AphiaIDs(asfis$definition, parallel = FALSE)) #parallelization returns very few matching results

asfis_worms_mapping <- data.frame(
  src_code = asfis$code,
  trg_code = asfis$AphiaID,
  src_codingsystem = "asfis",
  trg_codingsystem = "worms"
)
readr::write_csv(asfis_worms_mapping, "../fdi-mappings/global-to-global/cl_mapping_species_asfis_worms.csv")

#3- Build ASFIS codelist enriched with WoRMS record information
asfis_worms_species = cbind(
  code = asfis_worms_mapping$src_code,
  do.call(rbind, lapply(1:nrow(asfis_worms_mapping), function(i){
    rec = try(worrms::wm_record(asfis_worms_mapping[i,]$trg_code))
    if(is(rec,"try-error")){
      rec = rep(NA,27)
    }
    return(rec)
  }))
)
readr::write_csv(asfis_worms_species, "../fdi-codelists/global/cwp/cl_asfis_species_enriched_with_worms.csv")
