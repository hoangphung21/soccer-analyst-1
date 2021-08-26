/*
Partition By
*/

select FirstName, LastName, Gender, Salary,
count(gender) over (Partition By Gender) as totalGender
from SQLSimple1.dbo.EmployeeDemographic AS dem
join SQLSimple1.dbo.EmployeeSalary as sal
	on dem.EmployeeID = sal.EmployeeID

select FirstName, LastName, Gender, Salary,
count(gender) 
from SQLSimple1.dbo.EmployeeDemographic AS dem
join SQLSimple1.dbo.EmployeeSalary as sal
	on dem.EmployeeID = sal.EmployeeID
group by FirstName, LastName, Gender, Salary