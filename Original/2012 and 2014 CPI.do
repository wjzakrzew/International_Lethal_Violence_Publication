clear
cd  "C:\Users\Billy\Dropbox\Research Projects\SHR Research\Data - 4th submission\Original"
import excel "CPI 2014_FullDataSet.xlsx", sheet("CPI 2014") firstrow clear

rename CountryTerritory CountryName
keep CountryName CPI2014

save "CPI2014.dta", replace

**replace CountryName= "South Korea" if Country== "Korea (South)"


**CPI 2012
clear
cd  "C:\Users\Billy\Dropbox\Research Projects\SHR Research\Data - 4th submission\Original"
import excel "CPI2012_Results.xlsx", sheet("CPI 2012") firstrow clear
drop in 1
rename CountryTerritory CountryName
keep CountryName CPI2012Score
gen CPI2012=CPI2012Score
drop CPI2012Score

save "CPI2012.dta", replace
