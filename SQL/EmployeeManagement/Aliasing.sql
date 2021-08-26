/*
Aliasing
*/

select Demo.EmployeeID, Sal.Salary
from SQLSimple1.dbo.EmployeeDemographic as Demo
join SQLSimple1.dbo.EmployeeSalary as Sal
	on Demo.EmployeeID = Sal.EmployeeID

select Demo.EmployeeID , Demo.FirstName, Demo.LastName, Sal.JobTitle, Ware.Age
from SQLSimple1.dbo.EmployeeDemographic as Demo
left join SQLSimple1.dbo.EmployeeSalary as Sal
	on Demo.EmployeeID = Sal.EmployeeID
left join SQLSimple1.dbo.WareHouseEmployeeDemographics as Ware
	on Demo.EmployeeID = Ware.EmployeeID