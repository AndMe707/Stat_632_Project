pacman::p_load(
  tidyverse,
  jsonlite,
  httr,
  lubridate,
  DataExplorer,
  knitr
)


EI <- GET("http://ec2-54-174-131-205.compute-1.amazonaws.com/API/HDRO_API.php/indicator_id=103706")
EI2 <- fromJSON(rawToChar(EI$content))
EI3 <- tibble(
  Country = EI2$country_name,
  Education_Index = EI2$indicator_value
  )

EI4 <- unnest(EI3, Education_Index, keep_empty = T)
EI5 <- unnest(EI4, Education_Index, keep_empty = T)
EI5$Year <- names(EI5$Education_Index)

Y <- EI5

