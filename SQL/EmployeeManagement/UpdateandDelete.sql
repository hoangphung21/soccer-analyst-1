/*
Updating and Deleting Data
*/

Select * 
from SQLSimple1.dbo.EmployeeDemographic

update SQLSimple1.dbo.EmployeeDemographic
set age=31,Gender='Female'
where FirstName = 'Holly' and LastName='Flax'

delete 
from SQLSimple1.dbo.EmployeeDemographic
where EmployeeID = 1005