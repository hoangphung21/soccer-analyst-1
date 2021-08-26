/*
Union and Union All
*/
select EmployeeID,FirstName,Age 
from SQLSimple1.dbo.EmployeeDemographic
union
select EmployeeID,JobTitle,Salary
from SQLSimple1.dbo.EmployeeSalary
order by EmployeeID


select * 
from SQLSimple1.dbo.EmployeeDemographic
full outer join SQLSimple1.dbo.WareHouseEmployeeDemographics
	ON EmployeeDemographic.EmployeeID = WareHouseEmployeeDemographics.EmployeeID