///VOter turnout - IDEA//
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Polity"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Polity"

import excel "idea_voterturnout.xls", sheet("Worksheet") firstrow



keep Country Year VoterTurnoutDatabaseParliam

rename VoterTurnoutDatabaseParliam VoterTurnout
destring (VoterTurnout), replace percent


** Fix Countries **
replace Country="South Korea" if Country == "Korea, Rep."
replace Country="South Korea" if Country=="Korea, Republic of"

keep if Country == "South Korea"

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

keep Country Year VoterTurnout 
save "Voterturnout.dta", replace




