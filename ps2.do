ps2 do file
Randy R. Miller
Data Management
Dr. Okulicz-Kozaryn
10/10/19

* data comes from the department of education. I merged two sets - the first set is racial/ethnic demographics for select school districts in Camden County. The second set is other demographic information i.e. economic status, gender and so forth. 

use "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20Demographics%20Data%201.dta?raw=true"
*first, I loaded the first data sets, then I replaced the data with the second set and then back to the first. Following that, I completed the merge. 

use "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20Demographics%20Data%202.dta?raw=true", replace
*

use "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20Demographics%20Data%201.dta?raw=true", replace

merge 1:1 Name using "https://github.com/Rakeemagne/datamanagement1/blob/master/Camden%20County%20Demographics%20Data%202.dta?raw=true"

list
*upon completing the merge, I check on the list to ensure my data was all listed

drop in 1

list

drop in 4

generate White2 = White

recode White2 (1/3=1) (4/8=2)

tab White2

collapse White Latinx Black, by(Name)

list
