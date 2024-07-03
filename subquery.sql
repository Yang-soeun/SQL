-- 회사 급여 평균보다 더 많이 받는 사원
select empno, ename, sal from emp
where sal > (select avg(sal) from emp);

-- Davies 이후에 채용된 모든 사원
select last_name, hire_date from employees
where hire_date > (select hire_date from employees where last_name = 'Davies');

-- single row subquery
-- 사원 141의 직무 ID와 동일한 직무ID를 가진 사원을 표시
select * from employees
where job_id = (select job_id from employees where employee_id = 141)
and employee_id != 141;

-- Taylor와 직무는 동일하지만 급여는 더 많이 받는 사원을 표시
select last_name, job_id, salary from employees
where salary > (select salary from employees where last_name = 'Taylor')
and job_id = (select job_id from employees where last_name = 'Taylor');

-- subquery에서 group 함수 사용
-- 급여가 최저 급여와 같은 모든 사원의 성, 직무 ID 및 급여를 표시
select last_name, job_id, salary
from employees
where salary = (select min(salary) from employees);

select job_id, avg(salary)
from employees
group by job_id
having avg(salary) = (select min(avg(salary)) from employees group by job_id);

-- 다중행 서브쿼리
select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary from employees where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary from employees where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select first_name, department_id, salary
from employees
where (salary, department_id) in(select min(salary), department_id from employees group by department_id);


-- IN(A, B, C): A거나 B거나 C -> ANY
-- NOT IN(A, B, C): A도 아니고, B도 아니고, C도 아닌것 -> ALL
select emp.last_name
from employees emp
where emp.employee_id not in
(select mgr.manager_id from employees mgr);

select emp.last_name
from employees emp
where emp.employee_id not in
(select mgr.manager_id from employees mgr where mgr.manager_id is not null);

select emp.last_name
from employees emp
where not exists
(select 1 from employees mgr where mgr.manager_id = emp.employee_id);

select *
from (select empno, ename, sal*12 as ANN_SAL, deptno from emp) -- 인라인 뷰
where ANN_SAL >= 3500;

with annual as
(select empno, ename, sal*12 as ANN_SAL, deptno from emp)
select *
from annual
where ann_sal >= 3500;

-- select절 서브쿼리(스칼라 서브쿼리)
select ename, sal, 
(select grade_level from job_grades where e.sal between lowest_sal and highest_sal)as salgrade
from emp e;

select * from emp_1;

-- 실습 
select * 
from emp_1
where hiredate > (select hiredate from emp_1 where ename = '송중기');

select *
from emp_1
where age = (select age from emp_1 where ename = '손예진')
and ename != '손예진';

select * from emp_1
where sal > (select sal from emp_1 where ename = '박민영')
and agency_id = (select agency_id from emp_1 where ename = '박민영');


select ename , sal
from emp_1
where sal = (select min(sal) from emp_1);

select ename , sal
from emp_1
where sal = (select max(sal) from emp_1);


select ename, sal
from emp_1
where sal < any(select sal from emp_1 where ename like '박%');


select * from emp_1;

select e.ename, m.ename
from emp_1 e, emp_1 m
where e.mento_id = m.empno;

select e.ename, e.mento_id
from emp_1 e
where e.empno in (select m.mento_id from emp_1 m);

select e.ename, e.mento_id
from emp_1 e
where e.empno not in(select m.mento_id from emp_1 m where m.mento_id is not null);