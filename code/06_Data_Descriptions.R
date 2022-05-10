Variables <- colnames(All_X1)
Description <- c(
  "Year",
  "Country",
  "Education Index",
  "% of the population employed ages 15 and older",
  "Employment in agriculture (% of total employment)",
  "Employment in services (% of total employment)" ,
  "Estimated gross national income per capita, male (2017 PPP $)",
  "Estimated gross national income per capita, female (2017 PPP $)",
  "GDP per capita (2017 PPP $)",                       
  "Internet users, total (% of population)",                   
  "Life expectancy at birth (years)",                    
  "Mobile phone subscriptions (per 100 people)",
  "Pupil-teacher ratio, primary school (pupils per teacher)",
  "Rural population with access to electricity (%)",
  "Unemployment, total (% of labour force)",
  "Working poor at PPP$3.20 a day (% of total employment)",         
  "Labour force participation rate (% ages 15 and older)",
  "Skilled labour force (% of labour force)"
)

Description <- paste0(Description, " - provided by HDRO API")
Data_Description_1 <- data.frame(Variables, Description)


saveRDS(Data_Description_1, "final_project/data/HDR_Data_Description.rds")
