-- ������ �Լ�

-- ���� ���� �Լ�
select * from dual; -- ���� ���̺� ���� 1��

select lower('SQL Course') as lower,
upper('SQL Course') as upper,
initcap('SQL Course') as initcap
from dual;

select lower('SQL Course') as lower,
upper('SQL Course') as upper,
initcap('SQL Course') as initcap
from dept; -- dept ���̺��� �Ǽ���ŭ ����

-- data���尪�� ��Ȯ�� �𸦶�
select employee_id, last_name, department_id
from employees
where last_name = 'higgins'; -- ������ Higgins�� ����Ǿ� �ֱ� ������ �̷��� �ϸ� �ȳ���

-- �̷��� ����ϸ� �����͸� ��Ȯ�� ���� ã�� �� ����
select employee_id, last_name, lower(last_name), department_id
from employees
where lower(last_name) = 'higgins';

-- ���ڿ� ���� �Լ�
-- 1���� ����
select concat('hello', 'World') as concat,
substr('HelloWorld', 1, 5) as substr,
length('HelloWorld') as length,
instr('HelloWorld', 'W') as instr
from dual;

-- ���� ���� �Լ�
-- �ݿø�
select round(54.923, 2), round(45.923, 0), round(45.923,-1)
from dual;

select trunc(54.923, 2), trunc(45.923), trunc(45.923, -1)
from dual;

-- ��¥ ���� �Լ�
select sysdate from dual; -- ���� ��¥
alter session set nls_date_format = 'RR/MM/DD HH:MI:SS'; -- ��¥ format ����
select sysdate from dual;
alter session set nls_date_format = 'YYYY/MM/DD';

-- ��¥ + ����
select ADD_MONTHS('2004/01/01', 1) from dual; -- �Ѵ� ���ϱ�

-- ��ȯ �Լ�
select employee_id, to_char(hire_date, 'MM/YY') Month_Hired
from employees
where last_name = 'Higgins';

select employee_id, to_char(hire_date, 'year') Month_Hired
from employees
where last_name = 'Higgins';

select employee_id, to_char(hire_date, 'YYYY') Month_Hired
from employees
where last_name = 'Higgins';

-- �޷��� ��ȯ
select to_char(salary, 'L99G999D00') salary
from employees
where last_name = 'Higgins';

-- null�̸� 0����
select empno, comm, nvl(comm, 0), deptno
from emp;

select empno, sal, comm, sal+nvl(comm, 0)
from emp;

-- case
select last_name, job_id,
case job_id when 'IT_PROG' then 1.10*salary
when 'ST_CLERK' then 1.15*salary
when 'SA_REP' then 1.20*salary
else salary end "REVISED_SALARY"
from employees;


