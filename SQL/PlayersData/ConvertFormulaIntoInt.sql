/****** Script for SelectTopNRows command from SSMS  ******/
 SELECT short_name,[ls]
      ,[st]
      ,[rs]
      ,[lw]
      ,[lf]
      ,[cf]
      ,[rf]
      ,[rw]
      ,[lam]
      ,[cam]
      ,[ram]
      ,[lm]
      ,[lcm]
      ,[cm]
      ,[rcm]
      ,[rm]
      ,[lwb]
      ,[ldm]
      ,[cdm]
      ,[rdm]
      ,[rwb]
      ,[lb]
      ,[lcb]
      ,[cb]
      ,[rcb]
      ,[rb]
into fifa21
  FROM [FifaProjects].[dbo].[players_21]
  

--declare @t as table(val varchar(20))
--declare @t2 as table(val varchar(20))
--insert into @t values
--('1+3'),
--('2*3'),
--('9+3*2')


--declare @exp varchar(20)
--while(exists(select 1 from @t))
--begin
--    select top(1) @exp = val from @t

--    insert into @t2
--    exec ('select '+@exp)  

--    delete top (1) from @t
--end

--select * from @t2

declare @tabformula as table (id int identity(1,1), formulals varchar(200),formulast varchar(200),formulars varchar(200),formulalw varchar(200),formulalf varchar(200) )
declare @tabresult as table (id int, result int)


insert into @tabformula
select top(5) ls
from fifa21


declare c cursor for 
select ID,formulals 
from @tabformula 
declare @id as int 
declare @formulals as varchar(200)

open c fetch c into @id,@formulals 
while @@fetch_status=0 
begin 
	print @formulals insert into @tabresult (id,result) 
	exec( 'select '+ @id +','+@formulals ) 
	fetch c into @id,@formulals 
end 
close c deallocate c
select T1.id,t1.formulals,T2.result 
from @tabformula t1 
inner join
@tabresult t2 on t1.id=t2.id

select *
FROM fifa21

