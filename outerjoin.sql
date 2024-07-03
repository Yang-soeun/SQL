-- left outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on (e.department_id = d.department_id);

select e.last_name, e.department_id, d.department_name
from employees e , departments d
where e.department_id = d.department_id(+);

-- right outer join
select e.last_name, d.department_id, d.department_name
from employees e right outer join departments d
on(e.department_id = d.department_id);

-- 동일
select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id(+)= d.department_id;

select e.last_name, d.department_id, d.department_name
from employees e full outer join departments d
on(e.department_id = d.department_id);

select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id(+)= d.department_id
union
select e.last_name, e.department_id, d.department_name
from employees e , departments d
where e.department_id = d.department_id(+);

select last_name, department_name
from employees
cross join departments;

select last_name, department_name
from employees, departments;


-- 추가 실습
select e.ename, e.age, e.sal,a.agency_name
from emp_1 e, agency a
where e.agency_id = a.agency_id;

select e.ename, e.age, e.sal, a.agency_name, l.addr
from emp_1 e, agency a, loc_1 l
where e.agency_id = a.agency_id
and a.loc_id = l.loc_id;

select e.ename, e.age, e.sal, a.agency_name
from emp_1 e left outer join agency a
on e.agency_id = a.agency_id;

select * from emp_1;
select * from agency;
select * from loc_1;
select * from job_grades;

select e.ename, e.age, e.sal, j.grade_level
from emp_1 e, job_grades j
where e.sal between j.lowest_sal and j.highest_sal;

select e.ename, e.agency_id, a.agency_name
from emp_1 e, agency a
where e.agency_id(+)=a.agency_id;

select e.ename, e.agency_id, a.agency_name
from emp_1 e, agency a
where e.agency_id = a.agency_id(+)
union
select e.ename, e.agency_id, a.agency_name
from emp_1 e, agency a
where e.agency_id(+)=a.agency_id;

select e.ename, e.agency_id, a.agency_name
from emp_1 e full outer join agency a
on e.agency_id=a.agency_id;

select *
from emp_1 cross join agency;

select *
from emp_1, agency;

select * from emp_1;
select * from agency;
select * from loc_1;
select * from job_grades;

select e.ename, e.agency_id, a.loc_id, e.sal
from emp_1 e, agency a
where e.agency_id = a.agency_id and a.agency_name = '나무엑터스';

