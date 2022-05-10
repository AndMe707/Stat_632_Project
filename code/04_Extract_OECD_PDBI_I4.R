Q3_Data <- 'https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/PDBI_I4/AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+NMEC+BRA+BGR+CMR+CHN+HRV+CYP+HKG+IND+IDN+PER+ROU+SAU+SEN+SRB+SGP+ZAF.I4_ANA_GVAHRS+I4_ANA_GVAEMP+I4_ANA_GVA+I4_ANA_EMPTO+I4_ANA_HRSTO+I4_ANA_HRSAV+I4_ANA_CONILPHRS+I4_ANA_CONILPEMP+I4_ANA_ULCH+I4_ANA_LCHRS+I4_ANA_ULCE+I4_ANA_LCEMP.GRW.A_U+BNEXCL+B_E+BDE+C+F+GNEXCL+G_I+J+K+MN/all?startTime=1950&endTime=2021'
Q3_DSD <- 'https://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/PDBI_I4'

PDBI_I4_Data <- readSDMX(Q3_Data)
PDBI_I4_DSD <- readSDMX(Q3_DSD)

PDBI_I4_Data <- setDSD(PDBI_I4_Data, PDBI_I4_DSD)
PDBI_I4_Data <- as.data.frame(PDBI_I4_Data, labels = T)

PDBI_I4_Data2 <- PDBI_I4_Data %>% 
  select(!contains(".fr"))



colnames(PDBI_I4_Data2)[str_detect(colnames(PDBI_I4_Data2), ".en")] <- 
  gsub(".en", "", colnames(PDBI_I4_Data2)[str_detect(colnames(PDBI_I4_Data2), ".en")])

PDBI_I4_Data2$SUBJECT_label <- gsub(",.*", "", PDBI_I4_Data2$SUBJECT_label) %>% gsub(" ", "_", .)
PDBI_I4_Data2$ACTIVITY_label <- gsub(",.*", "", PDBI_I4_Data2$ACTIVITY_label) %>% gsub(" ", "_", .)


iter_list <- unique(PDBI_I4_Data2$SUBJECT_label[PDBI_I4_Data2$SUBJECT_label != "Unit_Labour_Costs"])
activity_iter_list <- unique(PDBI_I4_Data2$ACTIVITY_label[PDBI_I4_Data2$ACTIVITY_label != "Unit_Labour_Costs"])


PDBI_14 <- NULL
for (j in activity_iter_list){
  for(i in iter_list){
    temp <- PDBI_I4_Data2 %>% 
      select(LOCATION_label, SUBJECT_label, ACTIVITY_label, obsValue, obsTime) %>% 
      filter(SUBJECT_label == i, ACTIVITY_label == j) %>% 
      distinct(LOCATION_label, SUBJECT_label, ACTIVITY_label, obsTime, .keep_all = T) %>% 
      pivot_wider(names_from = c(SUBJECT_label, ACTIVITY_label), values_from = obsValue)
      
    PDBI_14 <- c(PDBI_14, list(temp)) 
      
  }
}

PDBI_14 <- PDBI_14 %>% 
  reduce(full_join, by = c("LOCATION_label", "obsTime"))

profile_missing(PDBI_14) %>% View()

keep <- as.character(profile_missing(PDBI_14)$feature[profile_missing(PDBI_14)$pct_missing < .29])
PDBI_14_v2 <- PDBI_14 %>% 
  select(keep) %>% 
  select(!contains("Total_"))%>%
  drop_na() 

saveRDS(PDBI_14_v2, "final_project/data/PDBI_14.RDS")
