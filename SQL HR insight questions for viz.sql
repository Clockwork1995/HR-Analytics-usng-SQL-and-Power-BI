-- QUESTIONS


-- What is the gender breakdown of employees in the company?

select gender, count(*) as count 
from hr
where age >= 18 and termdate = '0000-00-00'
group by gender;

-- What is the race/ethnicity breakdown of employees in the company?
select race, count(*) as count 
from hr
group by race
order by count desc;



-- What is the age distribution of employees in the company?

select 
	min(age) as youngest,
	max(age) as oldest 
from hr
where age >= 18 and termdate = '0000-00-00';

select 
	CASE
		WHEN AGE>=18 AND AGE <=24 tHEN '18-24'
		WHEN AGE>=25 AND AGE <=34 tHEN '25-34'
		WHEN AGE>=35 AND AGE <=44 tHEN '35-44'
		WHEN AGE>=45 AND AGE <=54 tHEN '45-54'
        WHEN AGE>=55 AND AGE <=64 tHEN '55-64'
        ELSE '65+'
	END AS age_group,
count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by age_group
order by age_group;

-- How the gender is distributed amongst the age_group?

select 
	CASE
		WHEN AGE>=18 AND AGE <=24 tHEN '18-24'
		WHEN AGE>=25 AND AGE <=34 tHEN '25-34'
		WHEN AGE>=35 AND AGE <=44 tHEN '35-44'
		WHEN AGE>=45 AND AGE <=54 tHEN '45-54'
        WHEN AGE>=55 AND AGE <=64 tHEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
	count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by age_group, gender
order by age_group, gender;

-- How many employees work at headquarters versus remote locations?

select location,count(*) as no_of_employees
from hr
where age >= 18 and termdate = '0000-00-00'
group by location;

-- What is the average length of employment for employees who have been terminated?
select 
	round(avg(datediff(termdate, hire_date))/365,2) as avg_length_employment
    from hr
    where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;


-- How does the gender distribution vary across departments and job titles?

select department, gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by department, gender
order by department;



-- What is the distribution of job titles across the company?

select jobtitle, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by jobtitle
order by jobtitle desc;

-- Which department has the highest turnover rate?

select department,
total_count,
terminated_count,
terminated_count/total_count as termination_rate
from(
select department,
count(*) as total_count,
sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminated_count
from hr
where age >= 18 
group by department

) as subquery

order by termination_rate desc;



-- What is the distribution of employees across locations by state?

select location_state, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by location_state
order by count desc;


-- How has the company's employee count changed over time based on hire and term dates?

select 
year,
hires,
terminations,
hires - terminations as net_change,
round((hires - terminations)/hires*100,2) as net_change_percent

from (
select year(hire_date) as year,
count(*) as hires,
sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminations
from hr
where  age >= 18
group by year(hire_date)
) as subquery

order by year asc;




-- What is the tenure distribution for each department?


select department, round(avg(datediff(termdate, hire_date))/365,2) as avg_tenure
from hr
where termdate <> '0000-00-00' and termdate <= curdate() and age>= 18
group by department
order by department;



