-- 1.
select * 
from employees e, departments d
where e.department_id = d.department_id;

-- 2.
select * from job_grades;
select e.employee_id, e.last_name, e.job_id, e.salary, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and highest_sal;

-- 3.
select * from departments;
select d.department_id, d.department_name, l.location_id, l.street_address
from departments d, locations l
where d.location_id = l.location_id;

-- 4.
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from locations l, countries c
where l.country_id = c.country_id;

-- 5.
select e.employee_id, e.last_name, e.job_id, e.salary, j.grade_level, d.department_name, l.city, c.country_name
from employees e, job_grades j, departments d, locations l, countries c
where e.salary between j.lowest_sal and highest_sal
and e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
order by j.grade_level desc, e.salary desc;

-- 6.
select e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto';

-- 7.
select d.department_id, d.department_name, round(avg(e.salary), 2), sum(e.salary), count(e.employee_id) as ÀÎ¿ø¼ö
from departments d, employees e
where d.department_id = e.department_id(+)
group by d.department_id, d.department_name
order by d.department_id;

