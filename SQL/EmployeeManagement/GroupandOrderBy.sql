/*
Group By, Order By
*/
select *
from SQLSimple1.dbo.EmployeeDemographic
order by gender, age desc

--select gender, COUNT(gender) as countgender
--from SQLSimple1.dbo.EmployeeDemographic
--where age >31
--group by Gender
--order by countgender 