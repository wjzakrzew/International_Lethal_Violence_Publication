** Tertiary Rate **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Education"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Education"
import excel "SK tertiary enrollment 1971_2017.xls", sheet("Data")

keep A AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG

rename (A AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW ///
AX AY AZ BA BB BC BD BE BF BG) (Country Y1983 Y1984 Y1985 Y1986 Y1987 Y1988 Y1989 ///
Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 Y1996 Y1997 Y1998 Y1999 Y2000 Y2001 Y2002 ///
Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014)

destring Y1983 Y1984 Y1985 Y1986 Y1987 Y1988 Y1989 Y1990 Y1991 Y1992 Y1993 ///
Y1994 Y1995 Y1996 Y1997 Y1998 Y1999 Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 ///
Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013 Y2014, replace force

drop in 1/4

replace Country="South Korea" if Country == "Korea, Rep."

keep if Country == "South Korea"


reshape long Y, i(Country) j(Year)
rename Y Tertiary


//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "Tertiary.dta", replace



