-- employess ���̺��� salary�� ���, �ְ�޿�,
-- �ּұ޿�, �޿��հ踦 �˻��Ͻÿ�
select avg(salary) as ���, 
max(salary)as �ְ�޿�, 
min(salary)as �ּұ޿�, 
sum(salary)as �޿��հ�
from employees;

-- employees ���̺��� �Ի����� ���� ���� hire_date��
-- ���� �ʰ� �Ի��� hire_date�� �˻��Ͻÿ�
select min(hire_date), max(hire_date)
from employees;

-- 50�� �μ��� ������� �˻��Ͻÿ�
select count(*)
from employees
where department_id = 50;

select count(commission_pct)
from employees
where department_id = 50;

select distinct department_id
from employees;

select count(*) from employees;

select avg(commission_pct) from employees;

select avg(nvl(commission_pct, 0)) from employees; --null ����
