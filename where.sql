-- where
-- ���ڿ� ������ ���� ����ǥ�� �ؾ���
-- where ���� ���� ���� ������ ���İ� ��Ȯ�� ��ġ�ؾ� ��
-- where ������ ����: ���� ������ ���� �� �ִ� ���ǽ� ����

select employee_id, last_name, job_id, department_id
from employees
where department_id = 90; -- ����

select last_name, job_id, department_id
from employees
where last_name = 'Whalen'; -- ���ϴ� ���ڿ��� ��ҹ��� ��Ȯ�ϰ� ��ġ�ؾ� ��

select last_name, job_id, department_id
from employees
where last_name = 'WHALEN'; -- ��� �ȳ���

select last_name, hire_date
from employees
where hire_date = '03/10/17'; -- ��� �ȳ���

select last_name, hire_date
from employees
where hire_date = '2003/10/17';

-- �񱳿�����
select last_name, salary
from employees
where salary <> 3000; -- NOT �ǹ�, != NOT �ǹ�

select last_name, salary
from employees
where salary between 2500 and 3500; -- �̻�, ����

-- ���ڿ��� between ��밡��
select last_name, salary
from employees
where last_name between 'King' and 'Whalen'
order by last_name;

--in
select employee_id, last_name, salary, manager_id
from employees
where manager_id in (100, 101, 201); -- in�� �ش��ϴ� ���� ����

-- like
select first_name
from employees where first_name like 'S%';

select last_name
from employees
where last_name like '_o%'; -- �տ��� �ι�° ���ڰ� o

select last_name
from employees
where last_name like '%o_'; -- �ڿ��� �ι�° ���ڰ� o

update emp set ename = 'SC%TT' where ename = 'SCOTT';
select ename from emp;

-- escape: C%�� ���Ե� ���ڿ� ã��
select ename from emp
where ename like '%C\%%' escape '\';

-- �̷��� �ϸ� C�� ���Ե� ename�� ����
select ename from emp
where ename like '%C%%';

rollback;

-- null
select last_name, manager_id, commission_pct
from employees
where manager_id is null;

select last_name, job_id, commission_pct
from employees
where commission_pct is not null;

-- �뷮���� �����͸� �ε��ϴ� ��� �� ������ ����, �ϳ��� �Ȱ����� ���� ���� �� �����
select * from dept where 3 = 3;

select * from dept where 3 = 0;

-- AND: �� ������ ��� ���� ��� true
-- OR: �� ���� �� �ϳ��� ���� ��� true
-- NOT: true�� false��, false�� true

select employee_id, last_name, job_id, salary
from employees
where salary >= 10000 and job_id like '%MAN%';

select employee_id, last_name, job_id, salary
from employees
where salary >= 10000 or job_id like '%MAN%';

-- ������ �켱����: AND > OR 
select last_name, department_id, salary
from employees
where department_id = 60
or department_id = 80
and salary > 1000;

-- ��������2
-- 1.
select last_name, salary
from employees
where salary > 12000;

-- 2.
select last_name, department_id
from employees
where employee_id = 176;

-- 3.
select last_name, salary
from employees
where not salary between 5000 and 12000;

-- 4.
select last_name, job_id, hire_date
from employees
where last_name in('Matos', 'Taylor')
order by hire_date;

-- 5.
select last_name, department_id
from employees
where department_id in(20, 50)
order by last_name;

-- 6.
select last_name as "Employee", salary as "Monthly Salary"
from employees
where (salary between 5000 and 12000) and department_id in(20, 50);

-- 7.
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

-- 8.
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';
