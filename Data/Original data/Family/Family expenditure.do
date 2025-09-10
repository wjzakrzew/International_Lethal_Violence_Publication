** GDP expenditure on family **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Family"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Family"
import excel "Family expenditure.xlsx", sheet("Data") firstrow

drop B

rename(ByFinancialResourcesandfunct C D E F G H I J K L M N O P Q R S T U V ///
W X Y Z AA) (Country Y1990 Y1991 Y1992 Y1993 Y1994 Y1995 Y1996 Y1997 Y1998 Y1999 ///
Y2000 Y2001 Y2002 Y2003 Y2004 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 ///
Y2013 Y2014)

replace Country = "South Korea" in 1


reshape long Y, i(Country) j(Year)
rename Y GDPFAMILY

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"

save "GDPFAMILY.dta", replace





