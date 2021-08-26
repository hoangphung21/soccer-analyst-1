/*
Having Clause
*/

Select JobTitle, avg(Salary) as 'AVG Salary'
from SQLSimple1.dbo.EmployeeDemographic
join SQLSimple1.dbo.EmployeeSalary
	on EmployeeDemographic.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having avg(Salary) > 45000
order by avg(Salary)