
Q_Data <- "https://stats.oecd.org/restsdmx/sdmx.ashx/GetData/MEI_REAL/PRINTO01+PRMNTO01+PRMNIG01+PRMNVG01+PREND401+PRENTO01+PRCNTO01+SLRTTO01+SLRTCR03+ODCNPI03+WSCNDW01.AUS+AUT+BEL+CAN+CHL+COL+CRI+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+NMEC+BRA+CHN+IND+IDN+RUS+ZAF.A/all?startTime=1919&endTime=2022"
Q_DSD <- "https://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/MEI_REAL"
data <- readSDMX(Q_Data)
dsd <- readSDMX(Q_DSD)
MEI_REAL <- setDSD(data, dsd)

MEI_REAL <- as.data.frame(MEI_REAL, labels = T)

MEI_REAL2 <- MEI_REAL %>% 
  select(!contains(".fr"))


colnames(MEI_REAL2)[str_detect(colnames(MEI_REAL2), ".en")] <- 
  gsub(".en", "", colnames(MEI_REAL2)[str_detect(colnames(MEI_REAL2), ".en")])

MEI_REAL2$SUBJECT_label <- gsub(",.*", "", MEI_REAL2$SUBJECT_label) %>% gsub(" ", "_", .)




MEI_REAL3 <-
  MEI_REAL2 %>% 
  select(LOCATION_label, SUBJECT_label, obsValue, obsTime) %>% 
  pivot_wider(names_from = SUBJECT_label, values_from = obsValue )


keep <- as.character(
  profile_missing(MEI_REAL3)$feature[profile_missing(MEI_REAL3)$pct_missing < .5]
)

MEI_REAL4 <- MEI_REAL3 %>% 
  select(keep)

saveRDS(MEI_REAL4, "final_project/data/MEI_REAL.rds")
