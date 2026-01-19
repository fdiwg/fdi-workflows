setwd("~/DEV/fdiwg/fdi-workflows")

iso2_to_iso3 = readr::read_csv("https://raw.githubusercontent.com/fdiwg/fdi-mappings/refs/heads/main/global-to-global/cl_mapping_country_and_territory_iso2_country_and_territory_iso3.csv")
m49_to_iso2 = readr::read_csv("https://raw.githubusercontent.com/fdiwg/fdi-mappings/refs/heads/main/global-to-global/cl_mapping_country_and_territory_m49_country_and_territory_iso2.csv")

#resolution width = 20
setwd("../flags/20")
iso2_images = list.files()
for(img in iso2_images){
	
	iso2 = toupper(unlist(strsplit(basename(img), "\\."))[1])
	
	iso3_rec = iso2_to_iso3[!is.na(iso2_to_iso3$src_code) & iso2_to_iso3$src_code == iso2,]
	if(nrow(iso3_rec) > 0){
		iso3 = iso3_rec$trg_code[1]
		file.copy(from = img, to = paste0(tolower(iso3), ".png"))
	}
	
	m49_rec = m49_to_iso2[!is.na(m49_to_iso2$trg_code) & m49_to_iso2$trg_code == iso2,]
	if(nrow(m49_rec) > 0){
		m49 = m49_rec$src_code[1]
		file.copy(from = img, to  = paste0(tolower(m49), ".png"))
	}
}

#resolution width = 40
setwd("~/DEV/fdiwg/fdi-workflows")
setwd("../flags/40")
iso2_images = list.files()
for(img in iso2_images){
	
	iso2 = toupper(unlist(strsplit(basename(img), "\\."))[1])
	
	iso3_rec = iso2_to_iso3[!is.na(iso2_to_iso3$src_code) & iso2_to_iso3$src_code == iso2,]
	if(nrow(iso3_rec) > 0){
		iso3 = iso3_rec$trg_code[1]
		file.copy(from = img, to = paste0(tolower(iso3), ".png"))
	}
	
	m49_rec = m49_to_iso2[!is.na(m49_to_iso2$trg_code) & m49_to_iso2$trg_code == iso2,]
	if(nrow(m49_rec) > 0){
		m49 = m49_rec$src_code[1]
		file.copy(from = img, to  = paste0(tolower(m49), ".png"))
	}
}

#resolution width = 80
setwd("~/DEV/fdiwg/fdi-workflows")
setwd("../flags/80")
iso2_images = list.files()
for(img in iso2_images){
	
	iso2 = toupper(unlist(strsplit(basename(img), "\\."))[1])
	
	iso3_rec = iso2_to_iso3[!is.na(iso2_to_iso3$src_code) & iso2_to_iso3$src_code == iso2,]
	if(nrow(iso3_rec) > 0){
		iso3 = iso3_rec$trg_code[1]
		file.copy(from = img, to = paste0(tolower(iso3), ".png"))
	}
	
	m49_rec = m49_to_iso2[!is.na(m49_to_iso2$trg_code) & m49_to_iso2$trg_code == iso2,]
	if(nrow(m49_rec) > 0){
		m49 = m49_rec$src_code[1]
		file.copy(from = img, to  = paste0(tolower(m49), ".png"))
	}
}

#resolution width = 160
setwd("~/DEV/fdiwg/fdi-workflows")
setwd("../flags/160")
iso2_images = list.files()
for(img in iso2_images){
	
	iso2 = toupper(unlist(strsplit(basename(img), "\\."))[1])
	
	iso3_rec = iso2_to_iso3[!is.na(iso2_to_iso3$src_code) & iso2_to_iso3$src_code == iso2,]
	if(nrow(iso3_rec) > 0){
		iso3 = iso3_rec$trg_code[1]
		file.copy(from = img, to = paste0(tolower(iso3), ".png"))
	}
	
	m49_rec = m49_to_iso2[!is.na(m49_to_iso2$trg_code) & m49_to_iso2$trg_code == iso2,]
	if(nrow(m49_rec) > 0){
		m49 = m49_rec$src_code[1]
		file.copy(from = img, to  = paste0(tolower(m49), ".png"))
	}
}
