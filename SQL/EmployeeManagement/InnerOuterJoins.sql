/*
Inner joins, Full/Left/Right/ Outer Joins
*/
--Select * 
--From SQLSimple1.dbo.EmployeeDemographic

--Select * 
--From SQLSimple1.dbo.EmployeeSalary

select JobTitle,avg(Salary)
from SQLSimple1.dbo.EmployeeDemographic
inner Join SQLSimple1.dbo.EmployeeSalary
	ON EmployeeDemographic.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle= 'Salesman'
group by JobTitle