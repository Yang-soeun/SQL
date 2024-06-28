-- order by
-- null 값은 가장 큰 값으로 인식(Oracle, SQL Server는 반대)
select employee_id, last_name, job_id, department_id, hire_date
from employees
order by employee_id asc;

select employee_id, last_name, job_id, department_id, hire_date
from employees
order by department_id desc;

select employee_id, last_name, salary*12 annsal
from employees
order by annsal; -- alias order by 절에 사용가능

select last_name, job_id, employee_id, department_id, hire_date
from employees
order by 3; -- 칼럼 숫자로 order by

select last_name, department_id, salary
from employees
order by department_id, salary desc; -- 동일 값에 대한 처리

select empno, ename, sal, deptno
from emp
order by deptno desc, sal asc; -- 칼럼마다 지정 가능