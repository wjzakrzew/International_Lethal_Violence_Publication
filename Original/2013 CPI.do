////////////////////////////////2013 CPI//////////////////////////////////////
clear
cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "CPI2013_GLOBAL_WithDataSourceScores.xls", sheet("CPI 2013") firstrow

keep CountryTerritory CPI2013Score

rename (CountryTerritory CPI2013Score)(CountryName CPI2013)

replace CountryName = "South Korea" if CountryName == "Korea (South)"
replace CountryName = "Cote d'Ivoire" if CountryName == "Côte d´Ivoire"
replace CountryName = "North Korea" if CountryName == "Korea (North)"



cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
save "CPI2013.dta", replace
/////////////////////////////////2011 CPI///////////////////////////////////////
clear
cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "CPI2011_Results.xls", sheet("take1") firstrow

keep country cpi11

gen CPI2011 = cpi11*10

drop cpi11

rename country CountryName

replace CountryName = "Cote d'Ivoire" if CountryName == "Côte d´Ivoire"


cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
save "CPI2011.dta", replace

/////////////////////////////////2010 CPI///////////////////////////////////////
clear
cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "CPI+2010+results_pls_standardized_data.xlsx", sheet("CPI table") firstrow

keep B C

drop in 1/3

rename(B C)(CountryName CPI2010)

destring CPI2010, replace force


gen cpi2010 = CPI2010*10
drop CPI2010
rename cpi2010 CPI200

replace CountryName = "South Korea" if CountryName == "Korea (South)"
replace CountryName = "Cote d'Ivoire" if CountryName == "Côte d´Ivoire"

cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
save "CPI2010.dta", replace

/////////////////////////////////Merged/////////////////////////////////////////
clear
cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

use "CPI2010.dta"

merge m:m CountryName using "CPI2011.dta"
drop _merge

merge m:m CountryName using "CPI2012.dta"
drop _merge

merge m:m CountryName using "CPI2013.dta"
drop _merge

merge m:m CountryName using "CPI2014.dta"
drop _merge

reshape long CPI, i(CountryName) j(Year)

replace Year = 2010 if Year ==200

drop if CountryName ==""
cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"

save "CPI.dta", replace





