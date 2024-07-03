-- 1.
select employee_id, last_name, salary, hire_date , department_id
from employees
where hire_date < (select hire_date  from employees where employee_id = 101)
order by hire_date ;

-- 2.
select employee_id, last_name, salary, hire_date , department_id
from employees
where salary = (select max(salary) from employees);

--3. 
select employee_id, last_name, salary, hire_date , department_id
from employees
where department_id = (select department_id from employees where last_name = 'Abel')
and
salary > (select salary from employees where last_name = 'Zlotkey');

--4.
select * from job_grades;
select employee_id, last_name, salary, hire_date , department_id
from employees e, job_grades j
where salary between j.lowest_sal and j.highest_sal
and j.grade_level = 'C'
order by salary;