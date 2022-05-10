pacman::p_load(
  tidyverse,
  httr,
  jsonlite,
  lubridate,
  rsdmx,
  DataExplorer)

ID_List <- c(
  195606,
  181306,
  98306,
  181406,
  150606,
  150706,
  148306,
  123506,
  123606,
  53506,
  100806,
  174306,
  194906,
  149406,
  61006,
  43606,
  148206,
  69206,
  101406,
  89006,
  46006,
  45806,
  128306,
  46206,
  179706,
  181706,
  179406,
  112606,
  112506,
  140606,
  45106,
  153706,
  169806
)

Predictors <- c(
  "Carbon dioxide emissions, production emissions per capita (tonnes)",
  "Child labour (% ages 5-17)",
  "Child malnutrition, stunting (moderate or severe) (% under age 5)",
  "Child marriage, women married by age 18 (% of women ages 20?24 who are married or in union)",
  "Employment in agriculture (% of total employment)",
  "Employment in services (% of total employment)",
  "Employment to population ratio (% ages 15 and older)",
  "Estimated gross national income per capita, female (2017 PPP $)",
  "Estimated gross national income per capita, male (2017 PPP $)",
  "Foreign direct investment, net inflows (% of GDP)",
  "Forest area (% of total land area)",
  "Fossil fuel energy consumption (% of total energy consumption)",
  "GDP per capita (2017 PPP $)",
  "Homeless people due to natural disaster (average annual per million people)",
  "Homicide rate (per 100,000 people)",
  "Internet users, total (% of population)",
  "Labour force participation rate (% ages 15 and older)",
  "Life expectancy at birth (years)",
  "Literacy rate, adult (% ages 15 and older)",
  "Maternal mortality ratio (deaths per 100,000 live births)",
  "Mobile phone subscriptions (per 100 people)",
  "Primary school teachers trained to teach (%)",
  "Prison population (per 100,000 people)",
  "Pupil-teacher ratio, primary school (pupils per teacher)",
  "Ratio of education and health expenditure to military expenditure",
  "Rural population with access to electricity (%)",
  "Skilled labour force (% of labour force)",
  "Suicide rate, female (per 100,000 people, age-standardized)",
  "Suicide rate, male (per 100,000 people, age-standardized)",
  "Unemployment, total (% of labour force)",
  "Urban population (%)",
  "Working poor at PPP$3.20 a day (% of total employment)",
  "Youth unemployment rate (female to male ratio)"
)


Query_List <- paste0("http://ec2-54-174-131-205.compute-1.amazonaws.com/API/HDRO_API.php/indicator_id=", ID_List)

All_Xs <- Y

for (i in seq_along(Query_List)) {
  EI <- GET(Query_List[i])
  EI2 <- fromJSON(rawToChar(EI$content))
  
  if("indicator_value" %in% names(EI2)){
    print(i)
    EI3 <- tibble(
      Country = EI2$country_name,
      Value = EI2$indicator_value
    )
    
    EI4 <- unnest(EI3, Value, keep_empty = T)
    EI5 <- unnest(EI4, Value, keep_empty = T)
    EI5$Year <- names(EI5$Value)
    EI5$Value <- unlist(EI5$Value)
    colnames(EI5)[colnames(EI5) == "Value"] <- as.character(Predictors[i])
    
    All_Xs <- left_join(All_Xs, EI5, by = c("Country", "Year"))
  }
  
}

saveRDS(All_Xs, "final_project/data/Predictors.rds")
#create_report(All_X1)
#introduce(All_X1)
All_Xs <- All_Xs %>% mutate_if(is.list, unlist)
colnames(All_Xs)

keep <- as.character(
  profile_missing(All_Xs)$feature[profile_missing(All_Xs)$pct_missing < .61]
)

All_X1 <- All_Xs %>%  select(
  Year,
  Country,
  Education_Index,
  `Employment to population ratio (% ages 15 and older)`,
  `Employment in agriculture (% of total employment)`,
  `Employment in services (% of total employment)`,
  `Estimated gross national income per capita, male (2017 PPP $)`,
  `Estimated gross national income per capita, female (2017 PPP $)`,
  `GDP per capita (2017 PPP $)`,
  `Internet users, total (% of population)`,
  `Life expectancy at birth (years)`,
  "Mobile phone subscriptions (per 100 people)",
  "Pupil-teacher ratio, primary school (pupils per teacher)",
  "Rural population with access to electricity (%)",
  "Unemployment, total (% of labour force)",             
  `Working poor at PPP$3.20 a day (% of total employment)`,
  `Labour force participation rate (% ages 15 and older)`,
  `Skilled labour force (% of labour force)`
)

keep <- profile_missing(All_X1)$feature[profile_missing(All_X1)$pct_missing <.54]  %>% as.character()


saveRDS(All_X1, "final_project/data/EDI_Development_Data_PRE.rds")


All_X1 <- All_X1 %>% select(keep) %>% drop_na()

saveRDS(All_X1, "final_project/data/EDI_Development_Data.rds")

