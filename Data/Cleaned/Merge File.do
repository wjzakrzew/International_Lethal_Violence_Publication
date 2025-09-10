** Merge File **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"
use "Freedom(95-18).dta"

**Imports GDP
merge m:m Country Year using "GDP.dta"
drop _merge

**Imports Foreign_investment
merge m:m Country Year using "Foreign_investment.dta"
drop _merge

**Marriage to Divorce Ratio
merge m:m Year using "DMRatio.dta"
drop _merge

**EducationGDP - World Bank
merge m:m Country Year using "EDUGDP.dta"
drop _merge

**Voterturnout - IDEA
merge m:m Country Year using "Voterturnout.dta"
drop _merge

**Tertiary
merge m:m Country Year using "Tertiary.dta"
drop _merge

**Education_Index
merge m:m Country Year using "Education_Index.dta"
drop _merge

**GDPFAMILY
merge m:m Country Year using "GDPFAMILY.dta"
drop _merge

**Gini** //only 4 values//
merge m:m Country Year using "SKgini.dta"
drop _merge



/***Democracy
merge m:m CountryName using "Democracy.dta"
drop _merge

**Corruption
merge m:m CountryName using "Corruption.dta"
drop _merge
*/

replace Country="South Korea" if Country==""
sort Year
**Country needed to remove from the previous 12str setting
recast str Country

cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"
save "Merged.dta"



