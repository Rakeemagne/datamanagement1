//need way more code! we should meet asap and discuss

ps4 do file
Randy R. Miller
Data Management
Dr. Okulicz-Kozaryn
11/7/19
-------------------------------------------------------------------------------

//---------------------------- data management --------------------------------
//---------------------------------- ps4 --------------------------------------


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

//---------------------------------- ps4 --------------------------------------

/* I'll begin with merging all the the data to make one data set. I took time to 
save each set as a .dta file and uploaded each to my github listing. Again, each
data set was gathered from the sites in the (Data Source Citation) listed above.
For an easier begin point, I will use the already merged data.
*/

use "https://github.com/Rakeemagne/datamanagement1/blob/master/Charter%20School%20Data%20Completed%20Merge.dta?raw=true"

/*To start, I want to give an overview of what charter schools in the state of 
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
graph pie BLKMDAYS LATMDAYS BLKFDAYS LATDAYS

/*Next, we look at the impact Black teachers have on Black student discipline 
by taking a look at a scatterplot of the three areas (ISS, OSS and DAYS) to see
how that factors in with respect to the population of Black teachers in charter
schools We look at Black young men first.
*/

scatter BLKMDAYS BLKMISS BLKMOSS BLKTEA
twoway scatter BLKTEA BLKMISS || lfit BLKTEA BLKMISS
twoway scatter BLKTEA BLKMOSS || lfit BLKTEA BLKMOSS
twoway scatter BLKTEA BLKMDAYS || lfit BLKTEA BLKMDAYS

/*We then explore other possible relationships to see what that tells us. I 
look at Black administrators and teachers of color because that could provide us
more insight. Considering that white teachers and white administrators are the
majority of educators, using them as the variable here may not tell us anything
significant.
*/

scatter BLKMDAYS BLKMISS BLKMOSS BLKADM
twoway scatter BLKADM BLKMISS || lfit BLKADM BLKMISS
twoway scatter BLKADM BLKMOSS || lfit BLKADM BLKMOSS
twoway scatter BLKADM BLKMDAYS || lfit BLKADM BLKMDAYS

scatter BLKMDAYS BLKMISS BLKMOSS POCTEA
twoway scatter POCTEA BLKMISS || lfit POCTEA BLKMISS
twoway scatter POCTEA BLKMOSS || lfit POCTEA BLKMOSS
twoway scatter POCTEA BLKMDAYS || lfit POCTEA BLKMDAYS

/*Based on what the data is showing us, it seems that the more there are Black 
educators in a charter school, the more Black male students are disciplined. 
Research shows that where there are more Black teachers, Black students are 
disciplined less. This is interesting. Now we look at Black young women to see
if that data tells us something different.
*/

scatter BLKFDAYS BLKFISS BLKFOSS BLKTEA
twoway scatter BLKTEA BLKFISS || lfit BLKTEA BLKFISS
twoway scatter BLKTEA BLKFOSS || lfit BLKTEA BLKFOSS
twoway scatter BLKTEA BLKFDAYS || lfit BLKTEA BLKFDAYS

scatter BLKFDAYS BLKFISS BLKFOSS BLKADM
twoway scatter BLKADM BLKFISS || lfit BLKADM BLKFISS
twoway scatter BLKADM BLKFOSS || lfit BLKADM BLKFOSS
twoway scatter BLKADM BLKFDAYS || lfit BLKADM BLKFDAYS

scatter BLKFDAYS BLKFISS BLKFOSS POCTEA
twoway scatter POCTEA BLKFISS || lfit POCTEA BLKFISS
twoway scatter POCTEA BLKFOSS || lfit POCTEA BLKFOSS
twoway scatter POCTEA BLKFDAYS || lfit POCTEA BLKFDAYS

/*According to the graphs, it seems that the data is saying the same thing for
Black girls as it does for Black boys where Black charter school teachers are 
concerned. It seems that Black students are disciplined the more Black teachers
there are. Why is that? It may have to do with the more stringent rules in 
Charter schools. It will require greater study.
