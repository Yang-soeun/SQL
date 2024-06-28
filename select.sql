-- select
select * from departments;
select department_id, department_name, manager_id, location_id from departments;

-- desc == DESCRIBE
DESCRIBE employees;
desc departments;

-- ��¥ ���� ����**
alter session set nls_date_format = 'YYYY/MM/DD';

-- ��Ģ ����
select last_name, salary, salary + 300
from employees;

-- ������ �켱����
select last_name, salary, 12*salary+100
from employees;

select last_name, salary, 12*(salary+100)
from employees;

-- null: �� X
select last_name, job_id, salary, commission_pct
from employees;

-- null���� ������� ����� null
select last_name, 12*salary*commission_pct
from employees;

select last_name, salary, commission_pct, salary+commission_pct
from employees;

-- ��¥ ����
select last_name, hire_date, hire_date + 300
from employees;

select last_name, hire_date, hire_date - 300
from employees;

-- ��¥�� +-�� ���� * �Ұ���
select last_name, hire_date, hire_date * 300
from employees;

-- Alias ��Ī
-- Alias�� �Ӹ����� �빮�ڷ� ��Ÿ����.
-- ����, Ư�� ���� ����, ��ҹ��ڸ� �����ϴ� ��� alias �� ū ����ǥ�� ����
-- || �� �� ����

select last_name|| ' is a ' || job_id AS "Employees Details"
from employees;

-- ���� �빮�ڷ� ����
select last_name AS name, commission_pct comm
from employees;

-- ��ҹ��� ���еż� ����
select last_name AS "Name", salary*12 "Annual Salary"
from employees;

-- �ߺ� ����
select department_id
from employees;

-- distinct�� �� �տ� �;���
-- department_id, distinct job_id �ȵ�
select distinct department_id, job_id
from employees;
