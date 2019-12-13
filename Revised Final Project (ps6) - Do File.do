/*ps6 do file
Randy R. Miller
Data Management
Dr. Okulicz-Kozaryn
12/15/19
-------------------------------------------------------------------------------*/ 

//---------------------------- data management --------------------------------
//---------------------------------- ps6 --------------------------------------


/*Preamble
For this problem set, I finalized the data that I will use for my final 
project by organizing it so to provide by graphs of interest to understanding 
whether or not research questions are answered by the data. I started to gain a
better picture of the impact of Black teachers in charter schools within NJ. I 
initally looked to make my focus all school districts in NJ (674). But the large 
sample complicated my ability to complete the tasks laid out in previous 
problem sets. I could have minimized my number of schools by focusing on one 
county in particular, but rather I chose to focus on charter schools because 
charter schools (89) provides me with a small enough number as to not complicate
organizing the data while at the same time providing me with the maximum sample 
size for that category of schools. In addition to providing graphs, I also run
a regression or two to understand exactly what the data tells us about our 
research questions
*/

/*Research Goal
This research is to explore the impact Black teachers have in charter schools 
in two key areas: Black student discipline and Black student academic 
achievement as per student test scores.
*/

/*Research Questions
1. Does a charter school and/or district suspend fewer black students when 
there are more Black teachers employed in that charter school and/or district?
2. Does a charter school and/or district produce higher test scores for Black 
students when there are more Black teachers employed in that charter school and/
or district? (WE'LL DISCUSS THIS MORE IN THE FINAL PROJECT)
*/

/*Hypothesis
1. Charter schools and/or districts do suspend fewer black students when 
there are more Black teachers employed in that charter school and/or district 
2. Charter schools and/or districts produce higher test scores for Black 
students when there are more Black teachers employed in that charter school and/
or district? (WE'LL DISCUSS THIS MORE IN THE FINAL PROJECT)
*/

/*Data Description
Data for this study comes from various sources. The first source (1) is school 
performance data from the NJ state department of education. This is data that
provides provide families, educators and the public valuable information about 
how a school is doing across several sections: academic progress, college and
career readiness, etc. The Summary Reports compare school performance to overall
state performance and state targets. The second source (2) is the certificated 
staff data from the NJ state department of education. This data provides 
Information on the totals and percentages of teachers and administrators 
according to race and ethnicity. The third source (3) is student suspension data 
from the U.S. Department of Education Civil Rights Data Collection. This data
provides a variety of information including student enrollment and educational 
programs and services, most of which is disaggregated by race/ethnicity, sex, 
limited English proficiency, and disability. The fourth source (4) is Local 
Education Agency (School District) Universe Survey Data from the National 
Center for Education Statistics. This data provides basic information about all 
education agencies and the students for whose education the agencies are 
responsible. The fifth and final source (5) is municipal tax rates from the NJ 
Fact Book. This data source is published as a free public service by Rutgers' 
Center for Government Services that includes statistics on New Jersey’s 565 
municipalities, its legislative districts, counties, schools, elections, and 
people.
*/

/*Data Source Citation
1- School Performance Reports
(https://rc.doe.state.nj.us/ReportsDatabase.aspx)
2- NJ Certificated Staff
(https://www.state.nj.us/education/data/cs/)
3- Civil Rights Data Collection
(https://ocrdata.ed.gov/flex/Reports.aspx?type=school)
4- Local Education Agency (School District) Universe Survey Data
(https://nces.ed.gov/ccd/pubagency.asp)
5- New Jersey Fact Book
(https://njdatabook.rutgers.edu/) 
*/

//---------------------------------- ps6 --------------------------------------

/* I'll begin with merging all the the data to make one data set.*/

//////////////////////////////////////////////
///////          M E R G E   1		  ////////
//////////////////////////////////////////////              

use "https://github.com/Rakeemagne/datamanagement1/blob/master/1.1%20-%20Admin%20Data%20(NCES).dta?raw=true"
merge 1:1 NUMBER using "https://github.com/Rakeemagne/datamanagement1/blob/master/1.2%20-%20Discipline%20Data%20(CRDC).dta?raw=true"
drop _merge

/*With my first merge, I added discipline data for both Black and Latinx students. 
Charter school students in NJ are predominately Black and Latinx so when gathering 
the data, I focused on those two groups of students. However, the focus of my research 
is on Black students. Latinx students will serve as a comparison group at best.
*/

/*exploring discipline data*/
sum BLKMISS
tab BLKMISS
sum BLKFISS
tab BLKFISS
sum BLKMOSS
tab BLKMOSS
sum BLKFOSS
tab BLKFOSS
sum BLKMDAY
tab BLKMDAY
sum BLKFDAY
tab BLKFDAY

/*Looking at the data, what stands out is the disciplining of Black males in comparison
to Black females. First, the percent of Black male students that on average miss 
more days of school due to suspension is higher than the percent of Black female 
students who miss days of school. The same is true for in school and out of school 
suspensions; Black males make up the higher percentage.*/

pwcorr BLKMISS BLKADM
pwcorr BLKMOSS BLKADM
pwcorr BLKMDAY BLKADM
pwcorr BLKMISS POCADM
pwcorr BLKMOSS POCADM
pwcorr BLKMDAY POCADM
pwcorr BLKMISS WHTADM
pwcorr BLKMOSS WHTADM
pwcorr BLKMDAY WHTADM

/*Where boys are concerned, where there are more Black school administrators at a 
charter school the higher the percentage of black boys receieve an out of school 
suspension and the higher the percentage miss days at school. The relationship is 
statistically signifcant. The same cannot be said for administrators of color in 
general or White administrators. This sets up our future regression to test the 
statistical strength of this relationship further.*/

//////////////////////////////////////////////
///////          M E R G E   2		  ////////
//////////////////////////////////////////////

merge 1:1 NUMBER using "https://github.com/Rakeemagne/datamanagement1/blob/master/1.3%20-%20Municipal%20Data%20(NJDATABOOK).dta?raw=true"

drop _merge

rename MUNICTAX muntax
rename SCHTAX schtax
sum muntax schtax, detail
hist muntax
hist schtax
replace schtax = 3 if schtax>=0 &schtax<=.999
replace schtax = 4 if schtax>=1 &schtax<=1.85

//////////////////////////////////////////////
///////          M E R G E   3		  ////////
//////////////////////////////////////////////

merge 1:1 NUMBER using "https://github.com/Rakeemagne/datamanagement1/blob/master/1.4%20-%20Student%20Data%20(NJDOE-Enrollment).dta?raw=true"
drop _merge

//////////////////////////////////////////////
///////          M E R G E   4		  ////////
//////////////////////////////////////////////

merge 1:1 NUMBER using "https://github.com/Rakeemagne/datamanagement1/blob/master/1.5%20-%20Teacher%20Data%20(NJDOE-Staff).dta?raw=true"
drop _merge

/*Currently, the data is listed according number to represent each charter school 
in the dataset. To clean things a bit, I went ahead and labeled each value in the 
COUNTY variable the actual county where each school is located. Next, I went ahead 
and created a new variable "REGION" so that we could actually see if the schools 
were located in north, central or south Jersey. I labeled the values in REGION so we
could see where the schools are located.*/

tab COUNTY
label define COUNTY 1 "Atlantic" 2 "Bergen" 3 "Burlington" 4 "Camden" 5 "Cumberland" 6 "Essex" 7 "Hudson" 8 "Mercer" 9 "Middlesex" 10 "Monmouth" 11 "Morris" 12 "Passaic" 13 "Somerset" 14 "Sussex" 15 "Union" 16 "Warren"
label values COUNTY COUNTY
tab COUNTY
recode COUNTY (2 6/7 12 14/15 = 16) (8/11 = 13) (3/5 = 1), gen(REGION) 
label define REGION 16 "North" 13 "Central" 1 "South" 
label values REGION REGION
tab REGION

*I run a quick loop just to change the variable names so that we know what school year we're talking about

foreach x in * { 
rename `x' `x'_1516
}

/*To continue, here is an overview of what charter schools in the state of 
NJ look like. To do this, we look for the mean percentage of white teachers 
(WHTADM) versus adminsitrators of color (POCADM). We do the same for teachers.
*/

mean POCADM WHTADM
graph pie POCADM WHTADM

mean WHTTEA POCTEA
graph pie WHTTEA POCTEA

*Next we do the same with students.

mean BLKSTU LATSTU WHTSTU ASISTU
graph bar BLKSTU LATSTU WHTSTU ASISTU

/*Next begin to explore Black student discipline. From the previous chart, we 
notice that charter schools are predominately Black and Latinx in student 
makeup. With that said, we focus on Black and Latinx students taking a look at
in school suspension, out of school suspension and days missed.
*/

graph pie BLKMISS LATMISS BLKFISS LATFISS
graph pie BLKMOSS LATMOSS BLKFOSS LATFOSS
graph pie BLKMDAY LATMDAY BLKFDAY LATFDAY

/*Next, we look at the impact Black teachers have on Black student discipline 
by taking a look at a scatterplot of the three areas (ISS, OSS and DAYS) to see
how that factors in with respect to the population of Black teachers in charter
schools We look at Black young men first.
*/

scatter BLKMDAY BLKMISS BLKMOSS BLKTEA
twoway scatter BLKTEA BLKMISS || lfit BLKTEA BLKMISS
twoway scatter BLKTEA BLKMOSS || lfit BLKTEA BLKMOSS
twoway scatter BLKTEA BLKMDAY || lfit BLKTEA BLKMDAY

/*We then explore other possible relationships to see what that tells us. I 
look at Black administrators and teachers of color because that could provide us
more insight. Considering that white teachers and white administrators are the
majority of educators, using them as the variable here may not tell us anything
significant.
*/

scatter BLKMDAY BLKMISS BLKMOSS BLKADM
twoway scatter BLKADM BLKMISS || lfit BLKADM BLKMISS
twoway scatter BLKADM BLKMOSS || lfit BLKADM BLKMOSS
twoway scatter BLKADM BLKMDAY || lfit BLKADM BLKMDAY

scatter BLKMDAY BLKMISS BLKMOSS POCTEA
twoway scatter POCTEA BLKMISS || lfit POCTEA BLKMISS
twoway scatter POCTEA BLKMOSS || lfit POCTEA BLKMOSS
twoway scatter POCTEA BLKMDAY || lfit POCTEA BLKMDAY

/*Based on what the data is showing us, it seems that the more there are Black 
educators in a charter school, the more Black male students are disciplined. 
Research shows that where there are more Black teachers, Black students are 
disciplined less. This is interesting. Now we look at Black young women to see
if that data tells us something different.
*/

scatter BLKFDAY BLKFISS BLKFOSS BLKTEA
twoway scatter BLKTEA BLKFISS || lfit BLKTEA BLKFISS
twoway scatter BLKTEA BLKFOSS || lfit BLKTEA BLKFOSS
twoway scatter BLKTEA BLKFDAY || lfit BLKTEA BLKFDAY

scatter BLKFDAY BLKFISS BLKFOSS BLKADM
twoway scatter BLKADM BLKFISS || lfit BLKADM BLKFISS
twoway scatter BLKADM BLKFOSS || lfit BLKADM BLKFOSS
twoway scatter BLKADM BLKFDAY || lfit BLKADM BLKFDAY

scatter BLKFDAY BLKFISS BLKFOSS POCTEA
twoway scatter POCTEA BLKFISS || lfit POCTEA BLKFISS
twoway scatter POCTEA BLKFOSS || lfit POCTEA BLKFOSS
twoway scatter POCTEA BLKFDAY || lfit POCTEA BLKFDAY

/*According to the graphs, it seems that the data is saying the same thing for
Black girls as it does for Black boys where Black charter school teachers are 
concerned. It seems that Black students are disciplined the more Black teachers
there are. Why is that? It may have to do with the more stringent rules in 
Charter schools. It will require greater study. Now, to look at the impact of 
Black teachers on test scores. Following that, regression analysis on both.*/

twoway scatter SCHMAT BLKTEA || lfit SCHMAT BLKTEA
twoway scatter SCHLAL BLKTEA || lfit SCHLAL BLKTEA

twoway scatter SCHMAT POCTEA || lfit SCHMAT POCTEA
twoway scatter SCHLAL POCTEA || lfit SCHLAL POCTEA

twoway scatter SCHMAT BLKADM || lfit SCHMAT BLKADM
twoway scatter SCHLAL BLKADM || lfit SCHLAL BLKADM

/*Based on all of the plots, we find that where there are more teachers of color, 
Black teachers or Black administrators at a charter school, the percentage of students
who are proficient or highly proficient in math and language arts is less than if 
there were fewer teachers of color, Black teachers or Black administrators. Similar
discipline data, we need to control for other variables to really see if the 
relationships hold up*/ 
