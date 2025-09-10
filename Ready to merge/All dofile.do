///////////////////////////Homicide data////////////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "FullHomicide.xlsx", sheet("Sheet1") firstrow
rename (B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK) (Y2016 Y2015 Y2014 Y2013 Y2012 Y2011 Y2010 Y2009 Y2008 Y2007 Y2006 Y2005 Y2004 Y2003 Y2002 Y2001 Y2000 Y1999 Y1998 Y1997 Y1996 Y1995 Y1994 Y1993 Y1992 Y1991 Y1990 Y1989 Y1988 Y1987 Y1986 Y1985 Y1984 Y1983 Y1982 Y1981)
rename Countries Country
destring Y1981, replace force

**reshape wide to long**
reshape long Y, i(Country) j(Year)

replace Country= "Iran" if Country == "Iran (Islamic Rep of)"
replace Country= "Russia" if Country== "Russian Federation"
replace Country= "South Korea" if Country== "Republic of Korea"
replace Country="Macedonia" if Country == "TFYR Macedonia"
replace Country="Venezuela" if Country == "Venezuela (Bolivarian Republic of)"
replace Country="Hong Kong" if Country == "Hong Kong SAR"
replace Country="United States" if Country=="United States of America"


rename Y homicide
drop if homicide==.

save "Homicide.dta", replace
clear

//////////////////////////////////// Suicide Data //////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"

import excel using "FullSuicide.xlsx", sheet("Sheet1") firstrow
rename (B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK) (Y2016 Y2015 Y2014 Y2013 Y2012 Y2011 Y2010 Y2009 Y2008 Y2007 Y2006 Y2005 Y2004 Y2003 Y2002 Y2001 Y2000 Y1999 Y1998 Y1997 Y1996 Y1995 Y1994 Y1993 Y1992 Y1991 Y1990 Y1989 Y1988 Y1987 Y1986 Y1985 Y1984 Y1983 Y1982 Y1981)
rename Countries Country
destring Y1981, replace force
**reshape wide to long**
reshape long Y, i(Country) j(Year)

replace Country= "Iran" if Country == "Iran (Islamic Rep of)"
replace Country= "Russia" if Country== "Russian Federation"
replace Country= "South Korea" if Country== "Republic of Korea"
replace Country="Macedonia" if Country == "TFYR Macedonia"
replace Country="Venezuela" if Country == "Venezuela (Bolivarian Republic of)"
replace Country="Hong Kong" if Country == "Hong Kong SAR"
replace Country="United States" if Country=="United States of America"

rename Y suicide
drop if suicide==.

merge m:m Country Year using "Homicide.dta"
drop _merge

rename Country CountryName

**Restrict timeframe to 2000 - 2014
keep if Year >= 2000 & Year <= 2014


//create LVR + SHR
gen LVR = homicide + suicide
gen SHR = suicide/LVR

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "homcide_suicide.dta", replace

///////////////////////////// Freedom index ///////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel using "Freedom index 95-2003.xlsx", sheet("Sheet1") firstrow
keep name indexyear taxburden governmentspending

destring taxburden governmentspending, generate(tax govtspend) force
drop taxburden governmentspending
encode name, generate(name2)
egen id = group(name2)
sort name indexyear
rename (name indexyear) (CountryName Year)
keep CountryName Year tax govtspend

**Change country names to match other datasets
replace CountryName ="Cote d'Ivoire" if _n >= 361 & _n <= 369
replace CountryName ="Gambia" if CountryName=="The Gambia"
replace CountryName ="Myanmar" if CountryName=="Burma"
replace CountryName ="Bahamas" if CountryName== "The Bahamas"
replace CountryName ="Sao Tome and Principe" if CountryName== "São Tomé and Príncipe"
replace CountryName ="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName ="Saint Vincent and Grenadines" if CountryName == "Saint Vincent and the Grenadines"
replace CountryName ="Congo" if CountryName =="Republic of Congo"


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Freedom index 95-03.dta", replace
////////////////////////////////////////////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel using "freedom index 2004_2014.xlsx", sheet("Sheet1") firstrow

keep name indexyear taxburden governmentspending

destring taxburden governmentspending, generate(tax govtspend) force
drop taxburden governmentspending
encode name, generate(name2)
egen id = group(name2)
sort name indexyear
rename (name indexyear) (CountryName Year)
keep CountryName Year tax govtspend

**removes non alphabetical symbols
replace CountryName = "Cote d'Ivoire" if _n >= 442 & _n <= 452
replace CountryName = "Sao Tome and Principe" if _n >= 1725 & _n <= 1735

**Change country names to match other datasets
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic "
replace CountryName="Gambia" if CountryName=="The Gambia"
replace CountryName="Myanmar" if CountryName=="Burma"
replace CountryName="Bangladesh" if CountryName=="Bangladesh "
replace CountryName="Costa Rica" if CountryName=="Costa Rica "
replace CountryName="El Salvador" if CountryName=="El Salvador "
replace CountryName="Guatemala" if CountryName=="Guatemala "
replace CountryName="Honduras" if CountryName=="Honduras "

replace CountryName="Hungary" if CountryName=="Hungary "
replace CountryName="Jamaica" if CountryName=="Jamaica "
replace CountryName="Malaysia" if CountryName=="Malaysia "
replace CountryName="Mozambique" if CountryName=="Mozambique "

replace CountryName="Nicaragua" if CountryName=="Nicaragua "
replace CountryName="Pakistan" if CountryName=="Pakistan "

replace CountryName="Panama" if CountryName=="Panama "
replace CountryName="Paraguay" if CountryName=="Paraguay "
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "Saint Vincent and the Grenadines"

replace CountryName = "Thailand" if CountryName == "Thailand "
replace CountryName = "Bahamas" if CountryName== "The Bahamas"
replace CountryName = "Uruguay" if CountryName== "Uruguay "
replace CountryName = "Venezuela" if CountryName== "Venezuela "
replace CountryName ="Congo" if CountryName =="Republic of Congo "


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Freedom index 04-14.dta", replace

clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "Freedom index 04-14.dta"

merge m:m CountryName using "Freedom index 95-03.dta"

sort CountryName Year
keep if Year >= 2000 & Year <= 2014

drop _merge

/**Take average for Serbia and Montenegro
bysort CountryName Year: egen meantax = mean(tax) if CountryName == "Serbia and Montenegro"
bysort CountryName Year: egen meangovt = mean(govtspend) if CountryName == "Serbia and Montenegro"

bysort CountryName Year: gen dup = cond(_N==1,0,_n) if CountryName == "Serbia and Montenegro"
drop if dup ==2
replace tax = meantax if dup==1
replace govtspend = meangovt if dup ==1

drop meantax meangovt dup*/

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Freedom index 00-14.dta", replace

/////////////////////////////////////GDP////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel using "GDP per capita growth (annual %).xlsx", sheet("GDP per capita growth (annual %") firstrow
drop WorldDevelopmentIndicators C D-AR BH-BJ

rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)
drop in 1/4

replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."

replace CountryName="Gambia" if CountryName =="Gambia, The"
replace CountryName="Lao" if CountryName =="Lao PDR"
replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long Y, i(id) j(Year)
rename Y GDP
drop id
order CountryName Year GDP

keep if Year >= 2000 & Year <= 2014


/**Take average for Serbia and Montenegro
bysort CountryName Year: egen meangdp = mean(GDP) if CountryName == "Serbia and Montenegro"

bysort CountryName Year: gen dup = cond(_N==1,0,_n) if CountryName == "Serbia and Montenegro"
drop if dup ==2
replace GDP = meangdp if dup==1

drop meantax meangovt dup*/


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "GDP", replace

//////////////////////////////Gini//////////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel using "Gini World Bank.xls", sheet("Data") firstrow

drop WorldDevelopmentIndicators C D-AR BH-BJ
rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)
drop in 1/3

destring Y2000-Y2014, generate(y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014) force
drop Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014

replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName= "Syria" if CountryName == "Syrian Arab Republic"
replace CountryName= "Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName= "Congo" if CountryName =="Congo, Rep."

replace CountryName= "Gambia" if CountryName =="Gambia, The"
replace CountryName= "Lao" if CountryName =="Lao PDR"
replace CountryName= "Macao" if CountryName =="Macao SAR, China"
replace CountryName= "Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long y, i(id) j(Year)
rename y Gini
drop id
order CountryName Year Gini

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Gini", replace

/////////////////////////////////////Percent Female//////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "Sex ratio.xls", sheet("Data") first

drop WorldDevelopmentIndicators C D-AR BH-BJ
rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop in 1/3

destring Y2000-Y2014, generate(y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014) force
drop Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014

replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."

replace CountryName="Gambia" if CountryName =="Gambia, The"
replace CountryName="Lao" if CountryName =="Lao PDR"
replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long y, i(id) j(Year)
rename y pct_fem
drop id

gen sexratio = pct_fem/(100-pct_fem)
drop pct_fem
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "sexratio.dta", replace


////////////////////////////////////unemployment////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "pcunemployment.xls", sheet("Data") first

drop WorldDevelopmentIndicators C D-AR BH-BJ
rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop in 1/3

destring Y2000-Y2014, generate(y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014) force
drop Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014

replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."

replace CountryName="Gambia" if CountryName =="Gambia, The"
replace CountryName="Lao" if CountryName =="Lao PDR"
replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long y, i(id) j(Year)
rename y pcunemp
drop id
order CountryName Year pcunemp

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "pcunemp", replace


//////////////////////////////////Infant mortality//////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "Infant Mortality World Bank.xls", sheet("Data") first

drop WorldDevelopmentIndicators C D-AR BH-BJ
rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop in 1/3

destring Y2000-Y2014, generate(y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014) force
drop Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014

replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."

replace CountryName="Gambia" if CountryName =="Gambia, The"
replace CountryName="Lao" if CountryName =="Lao PDR"
replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long y, i(id) j(Year)
rename y infant
drop id
order CountryName Year infant

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "infant", replace

///////////////////////////////////////DMRatio/////////////////////////////////
**Marriage dataset
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "UNPD_WMD_2008_MARRIAGES.xls", sheet("CRUDE_MARRIAGE_RATE") firstrow

keep UnitedNationsDepartmentofEc F G I J L M O P
drop in 1/4
recast str UnitedNationsDepartmentofEc

destring (F G I J L M O P), replace force
rename(UnitedNationsDepartmentofEc F G I J L M O P)(CountryName Year1 marriage1 Year2 marriage2 Year3 marriage3 Year4 marriage4)

egen meanmarriage= rowmean(marriage1 marriage2 marriage3 marriage4)
keep CountryName meanmarriage

replace Country= "Iran" if Country == "Iran (Islamic Republic of)"
replace Country= "Russia" if Country== "Russian Federation"
replace Country= "South Korea" if Country== "Republic of Korea"

replace Country="Venezuela" if Country == "Venezuela (Bolivarian Republic of)"
replace Country="Hong Kong" if Country == "China-Hong Kong SAR"
replace Country="Macao" if Country == "China-Macao SAR"
replace CountryName="United States" if CountryName=="United States of America"
replace CountryName="North Korea" if CountryName == "Democratic Peoples Republic of Korea"
replace CountryName="Macedonia" if CountryName == "The former Yugoslav Republic of Macedonia"

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "marriage.dta", replace

/////////////////////////////////////Divorce///////////////////////////////////
clear 
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "UNPD_WMD_2008_DIVORCES.xls", sheet("CRUDE_DIVORCE_RATE")

keep A F G I J L M O P
drop in 1/5
recast str A

destring (F G I J L M O P), replace force
rename (A F G I J L M O P) (CountryName Year1 CDR1 Year2 CDR2 Year3 CDR3 Year4 CDR4)
drop in 164

egen CDR= rowmean(CDR1 CDR2 CDR3 CDR4)
keep CountryName CDR

replace CountryName="Iran" if CountryName == "Iran (Islamic Republic of)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Macedonia" if CountryName == "The former Yugoslav Republic of Macedonia"
replace CountryName="Venezuela" if CountryName == "Venezuela (Bolivarian Republic of)"
replace CountryName = "Russia" if CountryName== "Russian Federation"

replace CountryName = "Cabo Verde" if CountryName == "Cape Verde"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "Saint Vincent and the Grenadines"

replace CountryName="South Korea" if CountryName=="Republic of Korea"
replace CountryName="Hong Kong" if CountryName=="China-Hong Kong SAR"
replace CountryName="United States" if CountryName=="United States of America"
replace CountryName="Venezula" if CountryName=="Venezuela (Bolivarian Republic of)"
replace CountryName="Iran" if CountryName=="Iran (Islamic Republic of)"

replace Country="Macao" if Country == "China-Macao SAR"
replace CountryName="North Korea" if CountryName == "Democratic Peoples Republic of Korea"

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "CDR.dta", replace

clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "CDR.dta"

merge m:m CountryName using "marriage.dta"
drop _merge


drop if CDR==. | meanmarriage==.
gen DMRatio= CDR/(CDR+meanmarriage)
drop CDR meanmarriage

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "DMRatio.dta", replace

////////////////////////////Voterout-Parliament////////////////////////////////////////////
clear 
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "idea_vote.xlsx", sheet("Worksheet") firstrow

keep if Electiontype == "Parliamentary"
drop Electiontype
destring VoterTurnout, gen(turnout) force percent
drop VoterTurnout

rename Country CountryName
gen compul = 1 if Compulsoryvoting == "Yes"
replace compul = 0 if Compulsoryvoting == "No"

replace CountryName= "Cabo Verde" if CountryName == "Cape Verde"
replace CountryName="South Korea" if CountryName == "Korea, Republic of"
replace CountryName= "Russia" if CountryName== "Russian Federation"

replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName =="Congo, Democratic Republic of"
replace CountryName="Iran" if CountryName == "Iran, Islamic Republic of"
replace CountryName="Lao" if CountryName == "Lao People's Dem. Republic"

replace CountryName="Macedonia" if CountryName == "Macedonia, former Yugoslav Republic (1993-)"
replace CountryName="Micronesia" if CountryName == "Micronesia, Federated States of"
replace CountryName="Moldova" if CountryName == "Moldova, Republic of"

drop Compulsoryvoting

//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "IDEA_parliament.dta", replace

////////////////////////////Voterout-Presidental////////////////////////////////////////////
clear 
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "idea_vote.xlsx", sheet("Worksheet") firstrow

keep if Electiontype == "Presidential"
drop Electiontype Compulsoryvoting
destring VoterTurnout, gen(turnout_presi) force percent
drop VoterTurnout

rename Country CountryName
replace CountryName= "Cabo Verde" if CountryName == "Cape Verde"
replace CountryName="South Korea" if CountryName == "Korea, Republic of"
replace CountryName= "Russia" if CountryName== "Russian Federation"

replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName =="Congo, Democratic Republic of"
replace CountryName="Iran" if CountryName == "Iran, Islamic Republic of"

replace CountryName="Macedonia" if CountryName == "Macedonia, former Yugoslav Republic (1993-)"


//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "IDEA_presidential.dta", replace


////////////////////////Female labor////////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original\percent female in labor force.xls", sheet("Data") firstrow
drop WorldDevelopmentIndicators C D-AR BH-BK

rename(DataSource-BG)(CountryName y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014)

drop in 1/3

destring y2000-y2014, generate(Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014) force
drop y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014


replace CountryName="Russia" if CountryName=="Russian Federation"
replace CountryName="Kyrgyzstan" if CountryName=="Kyrgyz Republic"
replace CountryName = "Bahamas" if CountryName== "Bahamas, The"
replace CountryName= "Egypt" if CountryName == "Egypt, Arab Rep."

replace CountryName= "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."
replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"

replace CountryName= "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName= "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName= "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName= "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"

replace CountryName= "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName= "Slovakia" if CountryName == "Slovak Republic"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."

replace CountryName="Gambia" if CountryName =="Gambia, The"
replace CountryName="Lao" if CountryName =="Lao PDR"
replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

gen id = _n

reshape long Y, i(id) j(Year)
rename Y femalelabor
drop id
order CountryName Year femalelabor

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "femalelabor", replace

//////////////////////////////Fertility/////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "Fertility rate_World Bank.xls", sheet("Data")

drop C D E F G H I J K L M N O P Q R S T U V W X Y BH BI BJ
rename(A B Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG)(CountryName Country Y1981 Y1982 Y1983 Y1984 Y1985 Y1986 Y1987 Y1988 Y1989 Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 Y1996 Y1997 Y1998 Y1999 Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop in 1/4

reshape long Y, i(CountryName) j(Year)
rename Y Fertility_rate
destring Fertility_rate, generate(fertility) force
drop Fertility_rate

replace CountryName = "Bahamas" if CountryName == "Bahamas, The"
replace CountryName = "Egypt" if CountryName == "Egypt, Arab Rep."
replace CountryName = "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName = "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."

replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"
replace CountryName = "Russia" if CountryName== "Russian Federation"
replace CountryName = "Slovakia" if CountryName == "Slovak Republic"
replace CountryName = "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName = "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName = "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."
replace CountryName = "Gambia" if CountryName == "Gambia, The"


drop Country

keep if Year >= 2000 & Year <= 2014

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "fertility.dta", replace

//////////////////////////////////Pcurban///////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "PercentUrban World Bank.xls", sheet("Data") firstrow

drop WorldDevelopmentIndicators-AR BH-BJ
rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

reshape long Y, i(CountryName) j(Year)
rename Y PCURBAN

destring PCURBAN, generate(pcurban) force

drop PCURBAN

replace CountryName = "Bahamas" if CountryName == "Bahamas, The"
replace CountryName = "Egypt" if CountryName == "Egypt, Arab Rep."
replace CountryName = "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName = "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."

replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"
replace CountryName = "Russia" if CountryName== "Russian Federation"
replace CountryName = "Slovakia" if CountryName == "Slovak Republic"
replace CountryName = "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName = "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName = "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."
replace CountryName = "Gambia" if CountryName == "Gambia, The"

replace CountryName="Kyrgyzstan" if CountryName =="Kyrgyz Republic"

keep if Year >= 2000 & Year <= 2014

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "pcurban.dta", replace

/////////////////////////////////Education Index////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "Education Index.xlsx", sheet("Education Index") firstrow

drop EducationIndex C-AD AF AH AJ AL AN AP AR AT AV AX AZ-BE
rename(B-AY)(CountryName Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)
drop in 1

reshape long Y, i(CountryName) j(Year)
rename Y eduIndex

replace CountryName="Bolivia" if CountryName==" Bolivia (Plurinational State of)"
replace CountryName="Democratic Republic of Congo" if CountryName==" Congo (Democratic Republic of the)"
replace CountryName="Hong Kong" if CountryName == " Hong Kong, China (SAR)"
replace CountryName="Iran" if CountryName == " Iran (Islamic Republic of)"

replace CountryName="South Korea" if CountryName == " Korea (Republic of)"
replace CountryName="Laos" if CountryName == " Lao People's Democratic Republic"
replace CountryName="Micronesia" if CountryName == " Micronesia (Federated States of)"
replace CountryName="Moldova" if CountryName == " Moldova (Republic of)"

replace CountryName="Syria" if CountryName == " Syrian Arab Republic"
replace CountryName="Tanzania" if CountryName == " Tanzania (United Republic of)"
replace CountryName="Macedonia" if CountryName == " The former Yugoslav Republic of Macedonia"
replace CountryName="Venezuela" if CountryName == " Venezuela (Bolivarian Republic of)"
replace CountryName = "Russia" if CountryName== " Russian Federation"
replace CountryName = "Republic of Congo" if CountryName== " Congo"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == " Saint Vincent and the Grenadines"
replace CountryName = "Eswatini" if CountryName == " Eswatini (Kingdom of)"


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "eduindex.dta", replace

/////////////////////////////////Education GDP//////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "Education expenditure_World_Bank.xlsx", sheet("Education expenditure_World_Ban") firstrow

drop WorldDevelopmentIndicators C D-AR BH-BJ

rename(DataSource-BG)(CountryName Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop in 1/4

reshape long Y, i(CountryName) j(Year)
rename Y edu_gdp

replace CountryName = "Bahamas" if CountryName == "Bahamas, The"
replace CountryName = "Egypt" if CountryName == "Egypt, Arab Rep."
replace CountryName = "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName = "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."

replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"
replace CountryName = "Russia" if CountryName== "Russian Federation"
replace CountryName = "Slovakia" if CountryName == "Slovak Republic"
replace CountryName = "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName = "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName = "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."
replace CountryName = "Gambia" if CountryName == "Gambia, The"

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "edugdp.dta", replace

/////////////////////////WGI - Voice & Effectiveness///////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "WGIData.xlsx", sheet("WGIData") firstrow

keep CountryName IndicatorName G-T

keep if IndicatorName == "Voice and Accountability: Estimate"

rename(CountryName-T)(CountryName Indicator Y2000 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop Indicator

reshape long Y, i(CountryName) j(Year)
rename Y Voice

replace CountryName = "Bahamas" if CountryName == "Bahamas, The"
replace CountryName = "Egypt" if CountryName == "Egypt, Arab Rep."
replace CountryName = "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName = "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."

replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"
replace CountryName = "Russia" if CountryName== "Russian Federation"
replace CountryName = "Slovakia" if CountryName == "Slovak Republic"
replace CountryName = "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName = "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName = "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."
replace CountryName = "Gambia" if CountryName == "Gambia, The"


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "voice.dta", replace


//////////////////////////////Effectiveness/////////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"

import excel "WGIData.xlsx", sheet("WGIData") firstrow

keep CountryName IndicatorName G-T

keep if IndicatorName == "Government Effectiveness: Estimate"

rename(CountryName-T)(CountryName Indicator Y2000 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

drop Indicator

reshape long Y, i(CountryName) j(Year)
rename Y Effectiveness

replace CountryName = "Bahamas" if CountryName == "Bahamas, The"
replace CountryName = "Egypt" if CountryName == "Egypt, Arab Rep."
replace CountryName = "Hong Kong" if CountryName == "Hong Kong SAR, China"
replace CountryName = "Iran" if CountryName == "Iran, Islamic Rep."
replace CountryName="North Korea" if CountryName == "Korea, Dem. People’s Rep."
replace CountryName="South Korea" if CountryName == "Korea, Rep."

replace CountryName="Macedonia" if CountryName == "Macedonia, FYR"
replace CountryName = "Russia" if CountryName== "Russian Federation"
replace CountryName = "Slovakia" if CountryName == "Slovak Republic"
replace CountryName = "Saint Lucia" if CountryName == "St. Lucia"
replace CountryName = "Venezuela" if CountryName == "Venezuela, RB"
replace CountryName = "Virgin Islands (USA)" if CountryName == "Virgin Islands (U.S.)"
replace CountryName="Syria" if CountryName == "Syrian Arab Republic"
replace CountryName = "Saint Vincent and Grenadines" if CountryName == "St. Vincent and the Grenadines"
replace CountryName="Yemen" if CountryName =="Yemen, Rep."

replace CountryName="Macao" if CountryName =="Macao SAR, China"
replace CountryName="Democratic Republic of Congo" if CountryName=="Congo, Dem. Rep."
replace CountryName="Congo" if CountryName =="Congo, Rep."
replace CountryName = "Gambia" if CountryName == "Gambia, The"


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "effectiveness.dta", replace

////////////////////////////////PISA-MATH///////////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "pisa_math.xlsx", sheet("pisa-test-score-mean-performanc") firstrow

drop Code

rename (Entity PISAMeanperformanceonthema)(CountryName Math)

cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to Merge"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Math.dta", replace

//////////////////////////////PISA-READING//////////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "pisa_reading.xlsx", sheet("pisa_reading") firstrow

drop Code

rename(Entity PISAMeanperformanceonthere)(CountryName Reading)

cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to Merge"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Reading.dta", replace

////////////////////////////PISA-SCIENCE////////////////////////////////////////
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Original"
import excel "pisa_science.xlsx", sheet("pisa-test-score-mean-performanc") firstrow

drop Code

rename(Entity PISAMeanperformanceonthesc)(CountryName Science)

cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to Merge"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Science.dta", replace

merge m:m CountryName Year using "Math.dta"
drop _merge

merge m:m CountryName Year using "Reading.dta"
drop _merge

cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to Merge"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"

save "PISA.dta", replace

////////////////////////////////////WVS/////////////////////////////////////////
***WVS Cleaning File from original
clear
cd  "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
use "Full WVS.dta"

**Remove data outside timeframe of study
drop if S020<2000
drop if S020>2014

quietly destring *, replace

**keep only used variables
keep S017 S003 S020 A005 A003 D001 A001 A057 A004 E023 E263 E264 C041 A006 F028 D022 X025LIT F004 F034 C008 A066 A100 X025 X025LIT A083 A068 A085 A102 F064 F004 F050 F063 F034 

ds S020 S003 S017, not
recode `r(varlist)' (-5=.) (-4=.) (-3=.) (-2=.) (-1=.)


**Reverse code all necessary variables
revrs A005 A003 C041
revrs D001 A001 A057 
revrs A004 E023 E263 E264  
revrs A006 F028

cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
save "New_Full WVS_MissingConv.dta", replace


////////////////////////////////////////////////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Original"
use "New_Full WVS_MissingConv.dta"

//Family//
replace D022= 1-D022

//Education//
recode X025LIT (2=0)

//Religion//
recode F004 (1=3)(2=0)(3=1)
recode F034 (2=0) (3=0)

/////Renaming Vars//////////
rename S017 weight
rename S003 country
rename S020 year

**Economy
rename C008 Work_Leisure
rename revA005 Work_Imp
rename revA003	Leisure_Imp
rename revC041 WorkFirst

**Family
rename revD001 Fam_Trust
rename revA001 Fam_Imp
rename revA057	SpendTime_Family
rename D022 Marriage
 
**Education
rename A066 Edu_Member
rename A100 Active_Edu
rename X025 EduLevel
rename X025LIT Literate
rename A083 Unpaid_Edu

**Polity
rename revA004 Pol_Imp
rename A068 Pol_Member
rename A085 Unpaid_Pol
rename A102 Active_Pol
rename revE023 Pol_Int
rename revE263 Vot_Local
rename revE264 Vot_Nat

**Religion
rename revA006 Rel_Imp
rename F064 Str_Rel
rename F004 Life_God
rename F050 Believe_God
rename F063 God_Imp
rename revF028 Attend
rename F034 Rel_Person

decode country, gen(CountryName)
drop country

drop A005 A003 C041 D001 A001 A057 A004 E023 E263 E264 A006 F028
/*
**Some future country matching changes
replace CountryName="Vietnam" if CountryName=="Viet Nam"
replace CountryName="Serbia and Montenegro" if CountryName=="Serbia"
replace CountryName="Serbia and Montenegro" if CountryName=="Montenegro"
replace CountryName="United Kingdom" if CountryName=="Great Britain"
replace CountryName="Bosnia and Herzegovina" if CountryName=="Bosnia Herzegovina"
replace CountryName="Bosnia and Herzegovina" if CountryName=="SrpSka Republic"
replace CountryName="Czech Republic" if CountryName=="Czech Rep."
*/

order weight CountryName year 

**collapse to means
ds weight CountryName year, not
collapse (mean) `r(varlist)' [aweight=weight], by(CountryName year)

**Delete all missing variables(columns)
unab ALL: *

foreach var in `ALL' {
     gen test = sum(mi(`var'))
     if test[_N]==_N drop `var'
     drop test
     }

***************************************************
rename year Year


cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "WVS.dta", replace

///////////////////////////Merge non-WVS files//////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "homcide_suicide.dta"

** Gini index
merge m:m CountryName Year using "Gini.dta"
drop _merge

** GDP
merge m:m CountryName Year using "GDP.dta"
drop _merge

** Freedom index
merge m:m CountryName Year using "Freedom index 00-14.dta"
drop _merge

** sex ratio
merge m:m CountryName Year using "sexratio.dta"
drop _merge

** pcunemp
merge m:m CountryName Year using "pcunemp.dta"
drop _merge

** infant mortality
merge m:m CountryName Year using "infant.dta"
drop _merge

** DMRatio
merge m:m CountryName using "DMRatio.dta"
drop _merge

** Voter turnout + Compulsory voting
merge m:m CountryName using "IDEA_parliament.dta"
drop _merge
merge m:m CountryName using "IDEA_presidential.dta"
drop _merge

**Female labor
merge m:m CountryName Year using "femalelabor.dta"
drop _merge

** Fertility
merge m:m CountryName Year using "fertility.dta"
drop _merge

** Education index
merge m:m CountryName Year using "eduindex.dta"
drop _merge

** Edugdp
merge m:m CountryName Year using "edugdp.dta"
drop _merge

** Voice
merge m:m CountryName Year using "voice.dta"
drop _merge

** Effectiveness
merge m:m CountryName Year using "effectiveness.dta"
drop _merge

** pcurban
merge m:m CountryName Year using "pcurban.dta"
drop _merge

** PISA
merge m:m CountryName Year using "PISA.dta"
drop _merge

** Corruption
merge m:m CountryName Year using "CPI.dta"
drop _merge

**Manually put Hong Kong's infant mortality
replace infant = 2.9 if CountryName == "Hong Kong" & Year == 2000
replace infant = 2.7 if CountryName == "Hong Kong" & Year == 2001 
replace infant = 2.4 if CountryName == "Hong Kong" & Year == 2002
replace infant = 2.3 if CountryName == "Hong Kong" & Year == 2003
replace infant = 2.5 if CountryName == "Hong Kong" & Year == 2004
replace infant = 2.4 if CountryName == "Hong Kong" & Year == 2005
replace infant = 1.8 if CountryName == "Hong Kong" & Year == 2006
replace infant = 1.7 if CountryName == "Hong Kong" & Year == 2007
replace infant = 1.8 if CountryName == "Hong Kong" & Year == 2008
replace infant = 1.7 if CountryName == "Hong Kong" & Year == 2009
replace infant = 1.7 if CountryName == "Hong Kong" & Year == 2010
replace infant = 1.4 if CountryName == "Hong Kong" & Year == 2011
replace infant = 1.5 if CountryName == "Hong Kong" & Year == 2012
replace infant = 1.7 if CountryName == "Hong Kong" & Year == 2013
replace infant = 1.7 if CountryName == "Hong Kong" & Year == 2014

keep if Year >= 2010 & Year <= 2014
dropmiss LVR, obs force

drop if CountryName == "Puerto Rico"
/*drop if CountryName == "Puerto Rico"
drop if CountryName == "Venezuela"
drop if CountryName == "Israel"
drop if CountryName == "Macedonia"
drop if CountryName == "Albania"
drop if CountryName == "Guatemala"*/


drop if CountryName =="" 
collapse (mean) suicide-CPI, by(CountryName)

//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "non-WVS Merged.dta", replace

//cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
//save "non-WVS sensitivity.dta", replace

/////////////////Restrict WVS Sample to most recent years///////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "WVS.dta"

tostring Year, generate(year)
destring year, replace

drop Year
rename year Year

egen id = group(CountryName)

bysort id: egen lastdate = max(Year)

keep if Year==lastdate

drop Edu_Member Pol_Member Unpaid_Edu Unpaid_Pol Work_Leisure Marriage Str_Rel Literate SpendTime_Family lastdate Year id WorkFirst

//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "WVS_recent.dta", replace


////////////////////////Merge non_WVS with WVS//////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "WVS_recent.dta"

merge m:m CountryName using "non-WVS Merged.dta"
//merge m:m CountryName using "non-WVS sensitivity.dta"

keep if _merge==3
drop _merge

//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Merged.dta", replace

///////////////////////////////Full merged data/////////////////////////////////
clear
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "Merged.dta"

**CountryName needed to remove from the previous 12str setting
recast str CountryName


** z-standardize everything
for varlist Active_Edu-Gini tax govtspend DMRatio-Effectiveness Science-CPI: egen zX = std(X)

**Removes duplicates on CountryName, averaging all the years together.
collapse (mean) Active_Edu-zCPI, by(CountryName)


merge m:m CountryName using "WBPop.dta"
keep if _merge==3
drop _merge

**Economy**
**Economy - CFA**
sem (Economy -> ztax zgovtspend zGini zWork_Imp zLeisure_Imp, ), method(mlmv) latent(Economy) cov(Economy@1) means(Economy@0) nocapslatent
predict Economy, latent(Economy)

alpha ztax zgovtspend zGini zWork_Imp zLeisure_Imp, item //alpha = 0.70

/////////////////////////////////////////////////////////////////////////////////
**Family**
**Family - CFA**
sem (Family ->  zFam_Imp zfertility zDMRatio zfemalelabor, ), method(mlmv) latent(Family) cov(Family@1) means(Family@0) nocapslatent
predict Family, latent(Family)

alpha zFam_Imp zfertility zDMRatio zfemalelabor, item //alpha = 0.70

////////////////////////////////////////////////////////////////////////////////
**Education**
**Education - CFA**
sem (Education ->  zeduIndex zMath zReading zScience, ), method(mlmv) latent(Education) cov(Education@1) means(Education@0) nocapslatent
predict Education, latent(Education)

alpha zeduIndex zMath zReading zScience, item //alpha = 0.93

////////////////////////////////////////////////////////////////////////////////
**Religion**
**Religion - CFA**
sem (Religion ->  zRel_Imp zAttend zGod_Imp Rel_Person, ), method(mlmv) latent(Religion) cov(Religion@1) means(Religion@0) nocapslatent
predict Religion, latent(Religion)

alpha zRel_Imp zAttend zGod_Imp Rel_Person, item //alpha = 0.87

////////////////////////////////////////////////////////////////////////////////
**Polity** - Problematic
**Polity - CFA**
sem (Polity -> zEffectiveness zVoice zPol_Int zturnout zCPI, ), method(mlmv) latent(Polity) cov(Polity@1) means(Polity@0) nocapslatent
predict Polity, latent(Polity) 
alpha zEffectiveness zVoice zPol_Int zturnout zCPI, item //alpha = 0.74

//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
save "Full_Merged.dta", replace


//////////////////////////////Data Analysis/////////////////////////////////////
clear
cd "C:\Users\Jingyi Fei\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
//cd "C:\Users\jingy\Dropbox\SHR Research\Data - 4th submission\Ready to merge"
use "Full_Merged.dta", replace

for varlist Economy Family Polity Religion Education: sort X \ egen Xid = group(X)
sort CountryName

gen Eco_Fam = Economyid/Familyid
gen Eco_Edu = Economyid/Educationid
gen Eco_Rel = Economyid/Religionid
gen Eco_Pol = Economyid/Polityid

reg LVR Eco_Fam Eco_Edu Eco_Rel Eco_Pol, beta robust
vif
di e(r2_a)
outreg2 using Outout_II.doc, replace ctitle(Model 1)

reg LVR Eco_Fam Eco_Edu Eco_Rel Eco_Pol GDP sexratio pcunemp infant pcurban, beta robust
vif
di e(r2_a)
outreg2 using Outout_II.doc, append ctitle(Model 2)

reg SHR Eco_Fam Eco_Edu Eco_Rel Eco_Pol, beta robust
vif
di e(r2_a)
outreg2 using Outout_II.doc, append ctitle(Model 3)

reg SHR Eco_Fam Eco_Edu Eco_Rel Eco_Pol GDP sexratio pcunemp infant pcurban, beta robust
vif
di e(r2_a)
outreg2 using Outout_II.doc, append ctitle(Model 4)

sum LVR SHR homicide suicide Economy Family Education Religion Polity Eco_Fam Eco_Edu Eco_Rel Eco_Pol GDP sexratio pcunemp infant pcurban
sum tax govtspend Gini Work_Imp Leisure_Imp Fam_Imp fertility DMRatio femalelabor eduIndex Math Reading Science Rel_Imp Attend God_Imp Rel_Person Effectiveness Voice Pol_Int turnout CPI
pwcorr LVR SHR Economy Family Education Religion Polity GDP sexratio pcunemp infant pcurban, sig
////////////////////////////////////NBR Models//////////////////////////////////
gen lnpop = ln(Pop)

log using negative
nbreg homicide Eco_Fam Eco_Edu Eco_Rel Eco_Pol, offset(lnpop) vce(robust) irr
outreg2 using H_S.doc, replace ctitle(Model 1)

nbreg homicide Eco_Fam Eco_Edu Eco_Rel Eco_Pol GDP sexratio infant pcunemp pcurban, offset(lnpop) vce(robust) irr
outreg2 using H_S.doc, append ctitle(Model 2)

nbreg suicide Eco_Fam Eco_Edu Eco_Rel Eco_Pol, offset(lnpop) vce(robust) irr
outreg2 using H_S.doc, append ctitle(Model 3)

nbreg suicide Eco_Fam Eco_Edu Eco_Rel Eco_Pol GDP sexratio infant pcunemp pcurban, offset(lnpop) vce(robust) irr
outreg2 using H_S.doc, append ctitle(Model 4)

log close
translate negative.smcl negative.pdf
/////////////////////////////Use one single variable/////////////////////////////
//NOTE: NOT RECOMMEND
/*sem (imbalance -> Economy Family Education Religion Polity, ), method(mlmv) latent(imbalance) cov(imbalance@1) means(imbalance@0) nocapslatent
predict imbalance, latent(imbalance)
alpha Economy Family Education Religion Polity, item //alpha = 0.88


reg LVR imbalance, beta robust
vif
outreg2 using single.doc, replace ctitle(Model 1)

reg LVR imbalance GDP pct_fem pcunemp pcurban, beta robust
vif
outreg2 using single.doc, append ctitle(Model 2)

reg SHR imbalance, beta robust
vif
outreg2 using single.doc, append ctitle(Model 3)

reg SHR imbalance GDP pct_fem pcunemp pcurban, beta robust
vif
outreg2 using single.doc, append ctitle(Model 4)*/

gen imbalance = Economy/(Family+Education+Religion+Polity)
gen social = Family+ Education+ Religion+ Polity

/////////////////////////////////Sensitivity Check//////////////////////////////
reg SHR Economy Family Education Religion Polity, beta robust
vif
di e(r2_a)
outreg2 using Sensitivity.doc, replace ctitle(Model 1)

reg SHR Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, beta robust
vif
di e(r2_a)
outreg2 using Sensitivity.doc, append ctitle(Model 2)

reg LVR Economy Family Education Religion Polity, beta robust
vif
di e(r2_a)
outreg2 using Sensitivity.doc, append ctitle(Model 3)

reg LVR Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, beta robust
vif
di e(r2_a)
outreg2 using Sensitivity.doc, append ctitle(Model 4)


nbreg homicide Economy Family Education Religion Polity, offset(lnpop) vce(robust)
nbreg homicide Economy Family Education Religion Polity, offset(lnpop) vce(robust) irr
outreg2 using Sensitivity_HS.doc, replace ctitle(Model 1)

nbreg homicide Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust)
nbreg homicide Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr
outreg2 using Sensitivity_HS.doc, append ctitle(Model 2)

nbreg suicide Economy Family Education Religion Polity, offset(lnpop) vce(robust)
nbreg suicide Economy Family Education Religion Polity, offset(lnpop) vce(robust) irr
outreg2 using Sensitivity_HS.doc, append ctitle(Model 3)

nbreg suicide Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust)
nbreg suicide Economy Family Education Religion Polity GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr
outreg2 using Sensitivity_HS.doc, append ctitle(Model 4)

//////////////////////////////More alternatives/////////////////////////////////
reg SHR Economy social, beta robust
vif

reg SHR Economy social GDP sexratio pcunemp pcurban, beta robust
vif

reg LVR Economy social, beta robust
vif

reg LVR Economy social GDP sexratio pcunemp pcurban, beta robust
vif

nbreg homicide Economy social, offset(lnpop) vce(robust) irr

nbreg homicide Economy social GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr

nbreg suicide Economy social, offset(lnpop) vce(robust) irr

nbreg suicide Economy social GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr


reg SHR imbalance, beta robust
vif

reg SHR imbalance GDP sexratio pcunemp pcurban, beta robust
vif

reg LVR imbalance, beta robust
vif

reg LVR imbalance GDP sexratio pcunemp pcurban, beta robust
vif

nbreg homicide imbalance, offset(lnpop) vce(robust) irr

nbreg homicide imbalance GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr

nbreg suicide imbalance, offset(lnpop) vce(robust) irr

nbreg suicide imbalance GDP sexratio pcunemp pcurban, offset(lnpop) vce(robust) irr





