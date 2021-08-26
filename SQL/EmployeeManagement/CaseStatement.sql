/*
Case Statement
*/
--select FirstName,LastName,Age,
--case
--	when age = 38 then 'Stanley'
--	when age > 30 then 'OLD'
--	else'young'
--end
--from SQLSimple1.dbo.EmployeeDemographic
--where age is not null
--order by age

select FirstName,LastName,JobTitle,Salary,
case
	when JobTitle = 'Salesman' then Salary + (Salary*.1)
	when JobTitle = 'Accountant' then Salary + (Salary*.05) 
	when JobTitle = 'HR' then Salary + (Salary*.00001) 
	else Salary + (Salary*.03)
end as SalaryAfterRaise
from SQLSimple1.dbo.EmployeeDemographic
join SQLSimple1.dbo.EmployeeSalary
	on EmployeeDemographic.EmployeeID = EmployeeSalary.EmployeeID