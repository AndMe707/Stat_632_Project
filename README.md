# Data Description

I'd like to research the education index of the United States. The data for this is provided from the United Nations data (https://hdr.undp.org/en/indicators/103706). The data definition provided by the United Nations website is: Education index is an average of mean years of schooling (of adults) and expected years of schooling (of children), both expressed as an index obtained by scaling with the corresponding maxima. The data has education index for countries from 1990 to 2019. I'd like to primarily focus on the United States. I'd like to see if there is a relationship between the growth in revenue of various industries and the education index. I will be joining multiple datasets provided by the Federal Reserve Economic Data (FRED), and the Bureau of Economic Analysis (BEA). As of now I have 17 rows of data and 36 columns. 

# Data Cook Book

Column	|	Definition
--------|-----------	
Year	|	Year
Education_Index	|	Education Index provided by United Nations Human Development Reports
Tax_Rate_LB	|	Tax Rate Low Bracket provided by FRED
Tax_Rate_HB	|	Tax Rate High Bracket provided by FRED
Surplus_Deficit_Billions	|	Census Total Revenue minus Census Total Expenditures provided by FRED
FRED_Movie_Revenue_Millions	|	Movie Industry Revenue Millions provided by FRED
FRED_TV_Revenue_Millions	|	TV Industry Revenue Millions provided by FRED
FRED_Computer_Revenue_Millions	|	Computer Revenue Millions provided by FRED
Farms	|	GDP value added in Billions  by this Industry provided by BEA
Oil and gas extraction	|	GDP value added in Billions  by this Industry provided by BEA
Food and beverage and tobacco products	|	GDP value added in Billions  by this Industry provided by BEA
Apparel and leather and allied products	|	GDP value added in Billions  by this Industry provided by BEA
Manufacturing	|	GDP value added in Billions  by this Industry provided by BEA
Printing and related support activities	|	GDP value added in Billions  by this Industry provided by BEA
Machinery	|	GDP value added in Billions  by this Industry provided by BEA
Computer and electronic products	|	GDP value added in Billions  by this Industry provided by BEA
Electrical equipment, appliances, and components	|	GDP value added in Billions  by this Industry provided by BEA
Food and beverage stores	|	GDP value added in Billions  by this Industry provided by BEA
Retail trade	|	GDP value added in Billions  by this Industry provided by BEA
General merchandise stores	|	GDP value added in Billions  by this Industry provided by BEA
Publishing industries, except internet (includes software)	|	GDP value added in Billions  by this Industry provided by BEA
Motion picture and sound recording industries	|	GDP value added in Billions  by this Industry provided by BEA
Broadcasting and telecommunications	|	GDP value added in Billions  by this Industry provided by BEA
Data processing, internet publishing, and other information services	|	GDP value added in Billions  by this Industry provided by BEA
Securities, commodity contracts, and investments	|	GDP value added in Billions  by this Industry provided by BEA
Real estate	|	GDP value added in Billions  by this Industry provided by BEA
Computer systems design and related services	|	GDP value added in Billions  by this Industry provided by BEA
Administrative and support services	|	GDP value added in Billions  by this Industry provided by BEA
Hospitals	|	GDP value added in Billions  by this Industry provided by BEA
Nursing and residential care facilities	|	GDP value added in Billions  by this Industry provided by BEA
Social assistance	|	GDP value added in Billions  by this Industry provided by BEA
Performing arts, spectator sports, museums, and related activities	|	GDP value added in Billions  by this Industry provided by BEA
Amusements, gambling, and recreation industries	|	GDP value added in Billions  by this Industry provided by BEA
Food services and drinking places	|	GDP value added in Billions  by this Industry provided by BEA
Finance, insurance, real estate, rental, and leasing	|	GDP value added in Billions  by this Industry provided by BEA
National defense	|	GDP value added in Billions  by this Industry provided by BEA
