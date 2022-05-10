
df_done <- All_X1 %>%  left_join(MEI_REAL4,
                                 by = c("Country" = "LOCATION_label", "Year" = "obsTime"))


#profile_missing(df_done) %>% View()

keep <- as.character(profile_missing(df_done)$feature[profile_missing(df_done)$pct_missing < .80])


df_done2 <- df_done %>% 
  select(keep) %>%
  drop_na() 



df_done3 <- All_X1 %>%  left_join(PDBI_14_v2,
                                 by = c("Country" = "LOCATION_label", "Year" = "obsTime"))



#profile_missing(df_done3) %>% View()

keep <- as.character(profile_missing(df_done3)$feature[profile_missing(df_done3)$pct_missing < .80])


df_done4 <- df_done3 %>% 
  select(keep, - Year, -Country) %>% drop_na() 



saveRDS(df_done4, "final_project/data/EDI_Full_Dataset.rds")
