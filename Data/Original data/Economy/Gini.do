** Gini index **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Economy"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Economy"
import excel "Gini World Bank.xls", sheet("Data")

keep A AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG

destring AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG, replace force

rename (A AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB ///
BC BD BE BF BG)(Country Y1987 Y1988 Y1989 Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 ///
Y1996 Y1997 Y1998 Y1999 Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 ///
Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

replace Country="South Korea" if Country == "Korea, Rep."

keep if Country == "South Korea" //only have 4 values//

reshape long Y, i(Country) j(Year)
rename Y Gini

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "SKgini.dta", replace







