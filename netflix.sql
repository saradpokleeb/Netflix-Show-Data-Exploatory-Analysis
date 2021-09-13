




--alter table [pf].[dbo].[netflix$]
--add month_added int;
update [pf].[dbo].[netflix$]
set month_added = datepart(month,date_added)


--alter table [pf].[dbo].[netflix$]

--add year_added int;


update [pf].[dbo].[netflix$]
set year_added = datepart(year,date_added)


--alter table [pf].[dbo].[netflix$]
--add ages nvarchar(10);

update [pf].[dbo].[netflix$]
set ages = case when rating = 'TV-Y' then 'Kids'
				when rating = 'G' then 'Kids'
				when rating = 'TV-Y7' then 'Kids'
				when rating = 'TV-G' then 'Kids'
				when rating = 'PG' then 'Kids'
				when rating = 'TV-PG' then 'Kids'
				when rating = 'PG-13' then 'Teens'
				when rating = 'TV-14' then 'Teens'
				when rating = 'R' then 'Adults'
				when rating = 'TV-MA' then 'Adults'
				when rating = 'NC-17' then 'Adults'
				else Null
			end;


select top(10) *
from [pf].[dbo].[netflix$]


--Show number of Movies and TV Show in netflix

select type,count(*) as number
from [pf].[dbo].[netflix$]
group by type




--rating count  --https://help.netflix.com/th/node/2064/us 

select ages,rating,count(*) as number
from [pf].[dbo].[netflix$]
group by ages,rating
order by number desc



--Genre 

select type,count(*) as number
from(select Ltrim(value) as type
	 from [pf].[dbo].[netflix$]
	 cross apply string_split(listed_in,',')) b
group by type 
order by number desc


--Top creator country

select country,count(*) as show
from(select Ltrim(value) as country
	 from [pf].[dbo].[netflix$]
	 cross apply string_split(country,',')) c
group by country
order by show desc

--find growth of number of show in netflix for each country

select *,sum(shows_added) over (partition by country order by date_added)  as total_shows
from(select *,count(*) as shows_added
	from(select Ltrim(value) as country,date_added
		from [pf].[dbo].[netflix$]
		cross apply string_split(country,',')) a
	group by country,date_added) b
order by date_added 

























