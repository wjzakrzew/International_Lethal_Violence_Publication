//Transposing 2014-2016 Arrest Data and removing unnecessary variables//
clear 
cd "C:\Users\wjzak\Dropbox\UAlbany\Research Projects\IAT Vignettes\Data\Arrest Rates"
import excel "Arrests (CCJS)-Robbery and Homicide 2014-2016.xlsx", sheet("Sheet")

drop A B D
replace C= "TOTAL" in 5

gen id = _n

rename(C E G I)(Vars Y2014 Y2015 Y2016)
reshape long Y, i(id) j(Year)
rename Y Arrests

drop F H J
drop if id<=4
drop id

**Rename for the reshape for crime type
replace Vars="SEXUAL_VIOLENCE" if Vars=="SEXUAL VIOLENCE" 
destring Arrests, generate(Arrest) force
drop Arrests
reshape wide Arrest, i(Year) j(Vars) string

save "Arrests2014-2016.dta", replace
