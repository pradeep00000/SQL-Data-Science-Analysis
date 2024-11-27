create schema ds_jobs;
select * from ds_jobs.data_science_job;

#1. Count the number of records in the dataset.
select count(*) from ds_jobs.data_science_job;

#2. Retrieve all distinct job titles.
select distinct(job_title) from ds_jobs.data_science_job;

#3. Find the total salary in USD for all jobs.
select sum(Salary_in_usd )
from ds_jobs.data_science_job;

#4. List all employees working remotely.
select * from ds_jobs.data_science_job
where work_setting = 'Remote';

#5. Find the average salary (in USD) by experience level.
select experience_level , avg(salary_in_usd)
from ds_jobs.data_science_job
group by experience_level;

#6. Find the top 5 highest-paid jobs (in USD).
select job_title , Salary_in_usd
from ds_jobs.data_science_job
order by salary_in_usd desc
limit 5;

#7. Retrieve the number of jobs per employment type.
select employment_type , count(employment_type)
from ds_jobs.data_science_job
group by employment_type;

#8. Find the average salary for each job category.
select job_category , avg(salary_in_usd)
from ds_jobs.data_science_job
group by job_category;

#9. List all jobs in companies with large company sizes.
select job_title , company_size
from ds_jobs.data_science_job
where company_size = "L";

#10. Retrieve the maximum salary for each country.
select employee_residence , max(salary_in_usd)
from ds_jobs.data_science_job
group by employee_residence;

#11. Find the highest salary (in USD) for each 
#    combination of job category and employment type.
select job_category , employment_type , max(salary_in_usd)
from ds_jobs.data_science_job
group by job_category , employment_type;

#12. List all job titles where the average salary is above $100,000 USD.
select job_title , avg(salary_in_usd)
from ds_jobs.data_science_job
group by job_title
having avg(salary_in_usd) > 100000;

#13. Identify countries with the most remote jobs.
select employee_residence ,count(*) as remote_job_count
from ds_jobs.data_science_job
where work_setting = "Remote"
group by employee_residence
order by remote_job_count desc;

#14. Find the most common job title in each job category.
select job_title , job_category , count(*) as job_count
from ds_jobs.data_science_job
group by job_category , job_title
order by job_count desc ;

#15. Retrieve jobs where the salary is above the average
#    salary for their respective job category.
select job_title , Salary_in_usd , job_category
from ds_jobs.data_science_job j1
where salary_in_usd > (
	   select avg(salary_in_usd) 
       from ds_jobs.data_science_job j2
       where j1.job_category = j2.job_category);

#16. Find the percentage of jobs for each work setting type.
select work_setting , count(work_setting) 
          * 100.0 / (select count(work_setting)
		  from ds_jobs.data_science_job) as percentage
from ds_jobs.data_science_job
group by work_setting;

#17. List the top 3 countries with the highest average salary (in USD).
select employee_residence , avg(salary_in_usd)
from ds_jobs.data_science_job
group by employee_residence
order by avg(salary_in_usd) desc
limit 3;

#18. Identify the year with the highest total salary payouts.
select work_year , sum(salary_in_usd)
from ds_jobs.data_science_job
group by work_year
order by work_year
limit 1;

#19. Find jobs where the salary exceeds the average 
#    salary in their company location.
select job_title , company_location , salary_in_usd
from ds_jobs.data_science_job j1
where salary_in_usd > 
	  ( select avg(salary_in_usd) 
      from ds_jobs.data_science_job j2
      where j1.company_location = j2.company_location);

#20. Find the difference between the highest and lowest 
#    salary for each combination of work setting and employment type.
select work_setting, employment_type, 
       max(salary_in_usd) - min(salary_in_usd) as salary_range
from ds_jobs.data_science_job
group by work_setting, employment_type
order by salary_range desc;
