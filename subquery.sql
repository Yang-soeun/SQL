-- ȸ�� �޿� ��պ��� �� ���� �޴� ���
select empno, ename, sal from emp
where sal > (select avg(sal) from emp);

-- Davies ���Ŀ� ä��� ��� ���
select last_name, hire_date from employees
where hire_date > (select hire_date from employees where last_name = 'Davies');

-- single row subquery
-- ��� 141�� ���� ID�� ������ ����ID�� ���� ����� ǥ��
select * from employees
where job_id = (select job_id from employees where employee_id = 141)
and employee_id != 141;

-- Taylor�� ������ ���������� �޿��� �� ���� �޴� ����� ǥ��
select last_name, job_id, salary from employees
where salary > (select salary from employees where last_name = 'Taylor')
and job_id = (select job_id from employees where last_name = 'Taylor');

-- subquery���� group �Լ� ���
-- �޿��� ���� �޿��� ���� ��� ����� ��, ���� ID �� �޿��� ǥ��
select last_name, job_id, salary
from employees
where salary = (select min(salary) from employees);

select job_id, avg(salary)
from employees
group by job_id
having avg(salary) = (select min(avg(salary)) from employees group by job_id);

-- ������ ��������
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


-- IN(A, B, C): A�ų� B�ų� C -> ANY
-- NOT IN(A, B, C): A�� �ƴϰ�, B�� �ƴϰ�, C�� �ƴѰ� -> ALL
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
from (select empno, ename, sal*12 as ANN_SAL, deptno from emp) -- �ζ��� ��
where ANN_SAL >= 3500;

with annual as
(select empno, ename, sal*12 as ANN_SAL, deptno from emp)
select *
from annual
where ann_sal >= 3500;

-- select�� ��������(��Į�� ��������)
select ename, sal, 
(select grade_level from job_grades where e.sal between lowest_sal and highest_sal)as salgrade
from emp e;

select * from emp_1;

-- �ǽ� 
select * 
from emp_1
where hiredate > (select hiredate from emp_1 where ename = '���߱�');

select *
from emp_1
where age = (select age from emp_1 where ename = '�տ���')
and ename != '�տ���';

select * from emp_1
where sal > (select sal from emp_1 where ename = '�ڹο�')
and agency_id = (select agency_id from emp_1 where ename = '�ڹο�');


select ename , sal
from emp_1
where sal = (select min(sal) from emp_1);

select ename , sal
from emp_1
where sal = (select max(sal) from emp_1);


select ename, sal
from emp_1
where sal < any(select sal from emp_1 where ename like '��%');


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