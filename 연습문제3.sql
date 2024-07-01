--1.
select max(salary)as "Maximum", 
min(salary) as "Minimum", 
sum(salary) as "Sum", 
round(avg(salary)) as "Average"
from employees;

-- 2.
select job_id,
max(salary)as "Maximum", 
min(salary) as "Minimum", 
sum(salary) as "Sum", 
round(avg(salary)) as "Average"
from employees
group by job_id;

-- 3.
select job_id, count(*)
from employees
group by job_id;

-- 4.
select count(distinct manager_id) as "Number of Mangers"
from employees;

-- 5.
select max(salary) - min(salary) as "DIFFERENCE"
from employees;

-- 6.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by min(salary) desc;



