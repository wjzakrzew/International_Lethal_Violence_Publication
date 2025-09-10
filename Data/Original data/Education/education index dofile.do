** Education index dofile **
clear
//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Original data\Education"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Original data\Education"
import excel "education index_UN.xlsx", sheet("Sheet1")

drop in 1/4
drop A
rename(B C D E F G H I J K L M N O P)(Country Y1980 Y1985 Y1990 Y1995 ///
Y2000 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 Y2012 Y2013)

drop in 1

destring Y1980 Y1985 Y1990 Y1995 Y2000 Y2005 Y2006 Y2007 Y2008 Y2009 Y2010 Y2011 ///
Y2012 Y2013, replace force

drop in 196/205

reshape long Y, i(Country) j(Year)
rename Y eduIndex

replace Country="South Korea" if Country == "Korea (Republic of)"
keep if Country =="South Korea"

keep Country eduIndex Year

//cd  "C:\Users\jingy\Dropbox\IAT in SK Research\Data\Cleaned"
cd  "C:\Users\Jingyi Fei\Dropbox\IAT in SK Research\Data\Cleaned"


save "Education_Index.dta", replace
