** Economic Freedom Index **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Economy"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Economy"
import excel "Heritage_Foundation_data_1995-2018.xlsx", sheet("Sheet1") firstrow

destring indexyear indexyear overallscore propertyrights governmentintegrity ///
judicialeffectiveness taxburden governmentspending fiscalhealth businessfreedom ///
laborfreedom monetaryfreedom tradefreedom investmentfreedom financialfreedom, replace force

//3 variables don't have enough data - drop them//
drop judicialeffectiveness fiscalhealth laborfreedom

//Rename variables//
rename(name indexyear overallscore propertyrights governmentintegrity taxburden ///
governmentspending businessfreedom monetaryfreedom tradefreedom investmentfreedom ///
financialfreedom)(Country Year score propertyrights govt_int tax govt_spending ///
business monetary trade investiment financial)

cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "Freedom(95-18).dta"







