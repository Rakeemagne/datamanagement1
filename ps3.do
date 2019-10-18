*ps3 do file
*Randy R. Miller
*Data Management
*Dr. Okulicz-Kozaryn
*10/17/19

*My research looks at NJ Department of education data. While my data comes from the same source (NJDOE), the data is pulled from different places. The data comes from (1) school performance data, (2) student enrollment data, and (3) certificated staff data. For this problem set, I specifically focus on data for Camden County, NJ. I am concerned with finding relationships between teacher composition and student grades and disciplinary issues.*
//again it should be totally different datasets, not from the same source!
//and what is the hypothesis, model, variables
*To start, I pulled my data from what was saved from my github file. I merged the five different data sets one by one - each time dropping the label/variable (_merge).* 

//what is this data, where it exactly come from? i need to be able to find the source!
use "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20ED1.dta?raw=true"

merge 1:1 Name using "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20ED2.dta?raw=true"

drop _merge

merge 1:1 Name using "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20ED3.dta?raw=true"

drop _merge

merge 1:1 Name using "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20ED4.dta?raw=true"

drop _merge

merge 1:1 Name using "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20ED5.dta?raw=true"

drop _merge

list

drop ADMPAC ADMIND ADMASI ADMBLK ADMLAT ADMCOL ADMWHT ADM4 ADMDISEXP ADMEXP ARREST OSS ISS CA DUAL AP Migrant Military Foster Homeless EngLang Disabled TwoMore Indigenous Female Male Pacific

*I had to drop a large number of variables because when I previously attempted to reshape my data, I was told that the variables were not constant amongst other variables. Once I dropped some random variables from my list, I was able to reshape.

//no this doesnt work! if anything add string option
reshape long TEA, i(Name) j(Race)  string
//but even then have there bunch of stuff
ta Race
//and not sure if that makes sense


reshape wide TEA, i(Name) j(Race)
