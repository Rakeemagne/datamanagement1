/*ps5 DoFile
Randy R Miller
Data Management
Dr. Okulicz-Kozaryn
11/14/19
*/

/*Preamble
For this problem set, I finalized the data that I will use for my final project by organizing it so to provide by graphs of interest to understanding whether or not research questions are answered by the data. as with ps4, I am using charter schools (89) provides me with a small enough number as to not complicateorganizing the data while at the same time providing me with the maximum sample size for that category of schools.
*/
 

/*Research Goal (for ps5)
This research is to explore the impact teacher and student characteristics have on test score performance of charter schools students. 
*/

/*Research Questions
1. Does teacher quality and/or student characteristics impact test score performance by charter school students in New Jersey? 
*/

/*Hypothesis
1. Charter schools test score performance is impacted by teacher quality.
*/

use "https://github.com/Rakeemagne/datamanagement1/blob/master/Charter%20School%20Data%20Completed%20Merge.dta?raw=true"

*I run a quick loop just to change the variable names so that we know what school year we're talking about

foreach x in * { 
rename `x' `x'_1516
}

*For the purposes of this problem set, I want to explore the impact of particular variables have on student test score performance in charter schools. I take some variables in my list and put together a special list for them that I call "teacqual" to mean teacher quality. 

global teacqual PERCERT_1516 PERFIRST_1516 PERABST_1516 WHTTEA_1516 BLKTEA_1516

*We then summarize these variables to see what we have as we conduct our tests.

sum $teacqual

*Now, I want to conduct my explorations using a regression test. I want to see the impact of teacher quality on both math scores and lannguage arts scores on the PARCC exam for NJ students.

reg MATH_1516 $teacqual

reg LAL_1516 $teacqual

*What I find in both regressions is that the fewer first year teachers are at a charter school, the higher test scores are for charter school students in both math and language arts. What is particularly key is that we have as a variable the % of teachers in a charter school who are certified - PERCERT. These regressions show that with respect to student performance on the PARCC, teacher experience (to some degree) matters more than whether or not a teacher was certified; certification does not denote experience. With that said, I created another macro titled "studchar" to mean student population characteristics according to race/ethnicity.

global studchar BLKSTU_1516 LATSTU_1516 WHTSTU_1516 ASISTU_1516

sum $studchar

reg MATH_1516 $studchar

reg LAL_1516 $studchar

*According to the results of these tests, we cannot say that any of these variables impact student test scores. I will now run a regression using both macros to see overall impact on test score proficiency.

reg MATH_1516 $teacqual $studchar

*Here I decide to add a few more variables.

reg MATH_1516 $teacqual $studchar DIS_1516 ECONDIS_1516 CA_1516

*With respect to math scores, we find that when we combind the macros (and even when we add the three other variables) the more White teachers that are in a charter school, the higher math scores are. Next, we'll see about language arts scores. 

reg LAL_1516 $teacqual $studchar

reg LAL_1516 $teacqual $studchar DIS_1516 ECONDIS_1516 CA_1516

*We see that with respect to language arts scores, none of these variables have an impact.