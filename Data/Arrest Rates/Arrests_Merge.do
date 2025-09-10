//Transposing 1987-2013 Arrest Data and removing unnecessary variables//
clear 
cd "C:\Users\wjzak\Dropbox\UAlbany\Research Projects\IAT Vignettes\Data\Arrest Rates"
import excel "Arrests (CCJS)-Robbery and Homicide 1987-2013.xlsx", sheet("Sheet")
replace B = "ACCIDENTAL FIRE" in 5
replace B = "ARSON" in 6
drop A C 
gen id = _n

rename Y YZ
rename(B D F H J L N P R T V X Z AB AD AF AH AJ AL AN AP AR AT AV AX AZ BB BD)(Vars Y1987 Y1988 Y1989 Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 Y1996 Y1997 Y1998 Y1999 Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013)
reshape long Y, i(id) j(Year)
rename Y Arrests
drop E G I K M O Q S U W YZ AA AC AE AG AI AK AM AO AQ AS AU AW AY BA BC BE
**Drops the arresstee totals, and just keeps humber of arrests
drop if id <=3
drop id

**Rename for the reshape for crime type
replace Vars="OTHER" if Vars=="OTHER_VIOLENT CRIME" 
replace Vars="TOTAL" if Vars=="TOTAL (INPUT VALUE)" 
replace Vars="ACCIDENTAL_FIRE" if Vars=="ACCIDENTAL FIRE" 
destring Arrests, generate(Arrest) force
drop Arrests
reshape wide Arrest, i(Year) j(Vars) string

append using "Arrests2014-2016.dta"

cd  "C:\Users\wjzak\Dropbox\UAlbany\Research Projects\IAT Vignettes\Data\Merge"
save "Arrests.dta", replace







