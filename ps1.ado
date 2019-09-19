* ps1 do file
* Randy R. Miller
* Data Management
* Dr. Okulicz-Kozaryn
* 9/19/19

* load the NJDOE dataset
import excel "C:\Users\alitt_000\Desktop\NJDOE Dataset.xlsx", sheet("Sheet1")

* this data comes from the New Jersey Department of Education school performance database

cd
log
describe 
count
list
tab A
tab C
sample 50
list A(B)