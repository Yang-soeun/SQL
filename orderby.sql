-- order by
-- null ���� ���� ū ������ �ν�(Oracle, SQL Server�� �ݴ�)
select employee_id, last_name, job_id, department_id, hire_date
from employees
order by employee_id asc;

select employee_id, last_name, job_id, department_id, hire_date
from employees
order by department_id desc;

select employee_id, last_name, salary*12 annsal
from employees
order by annsal; -- alias order by ���� ��밡��

select last_name, job_id, employee_id, department_id, hire_date
from employees
order by 3; -- Į�� ���ڷ� order by

select last_name, department_id, salary
from employees
order by department_id, salary desc; -- ���� ���� ���� ó��

select empno, ename, sal, deptno
from emp
order by deptno desc, sal asc; -- Į������ ���� ����