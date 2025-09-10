**Education Expenditure dofile- World Bank
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Education"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Education"

import delimited "Education expenditure_World_Bank.csv", clear
keep v1 v2 v28 v29 v30 v31 v32 v33 v34 v35 v36 v37 v38 v39 v40 v41 v42 v43 v44 v45 v46 v47 v48 v49 v50 v51 v52 v53 v54 v55 v56 v57 v58 v59
drop in 1/3

rename(v1 v2 v28 v29 v30 v31 v32 v33 v34 v35 v36 v37 v38 v39 v40 v41 v42 v43 v44 ///
v45 v46 v47 v48 v49 v50 v51 v52 v53 v54 v55 v56 v57 v58 v59) (Country CountryCode ///
Y1983 Y1984 Y1985 Y1986 Y1987 Y1988 Y1989 Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 Y1996 Y1997 ///
Y1998 Y1999 Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)


** Fix Countries **
replace Country="South Korea" if Country == "Korea, Rep."
keep if Country == "South Korea"

reshape long Y, i(Country) j(Year)
rename Y EDUGDP

keep Country EDUGDP Year

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "EDUGDP.dta", replace


