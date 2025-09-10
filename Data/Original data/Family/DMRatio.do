** DMRatio **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Family"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Family"

import excel "SK Vital Stats 1970-2017 KOSIS.xlsx", sheet("Sheet1") firstrow

keep Byitems Totalfertilityratepersons Infantmortalityrateper1000 Crudemarriagerateper1000po Crudedivorcerateper1000pop

rename(Byitems Totalfertilityratepersons Infantmortalityrateper1000 ///
Crudemarriagerateper1000po Crudedivorcerateper1000pop) (Year Fertility_rate Infant_mortality_1000 ///
Marriage_1000 Divorce_1000)

//Infant mortality only has data 2000 onwards// so dropped it
drop Infant_mortality_1000

gen DMRatio_1000 = Marriage_1000/(Marriage_1000+Divorce_1000)

drop in 46/50

destring Year, replace force

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "DMRatio.dta", replace
