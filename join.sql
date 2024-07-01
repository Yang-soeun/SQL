-- 조인
-- Oracle
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

-- SQL(ANSI)
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on(e.deptno = d.deptno);
-- 위에꺼랑 같은 의미
select e.empno, e.ename, deptno, d.dname
from emp e natural join dept d;

select e.empno, e.ename, deptno, d.dname
from emp e join dept d
using(deptno);

-- nonequijoin
select * from job_grades;

select e.ename, e.sal, j.grade_level
from emp e, job_grades j
where e.sal between j.lowest_sal and j.highest_sal;

select * from emp;
select * from dept;

select e.ename, e.sal, d.loc
from emp e, dept d
where e.deptno = d.deptno 
and e.sal >= 3000;

-- self join
select worker.ename as emp, manager.ename as mgr
from emp worker, emp manager
where worker.mgr = manager.empno;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on (worker.manager_id = manager.employee_id);

-- 동일
select worker.last_name emp, manager.last_name mgr
from employees worker, employees manager
where worker.manager_id = manager.employee_id;

-- 3way join
-- oracle
select employee_id, city, department_name
from employees e, departments d, locations l
where d.department_id = e.department_id
and d.location_id = l.location_id;

-- sql
select employee_id, city, department_name
from employees e join departments d
on d.department_id = e.department_id
join locations l
on d.location_id = l.location_id;








