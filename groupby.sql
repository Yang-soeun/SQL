-- group by
select department_id, sum(salary)
from employees
group by department_id;

select department_id, job_id, sum(salary)
from employees
where department_id > 40
group by department_id, job_id
order by department_id;


-- �ְ� �޿��� 10000�� �Ѵ� �μ��� ����
-- �μ���ȣ�� �ְ� �޿��� ǥ��
select department_id, max(salary) as �ְ�޿�
from employees
group by department_id
having max(salary) > 10000;

-- $99,999�� �ڸ��� ���� ũ�� �ؾ� ���������� ����
select department_id, to_char(max(salary), '$99,999') as �ְ�޿�
from employees
group by department_id
having max(salary) > 10000;

-- �μ���ȣ�� �ְ�
-- �μ��� �ٹ� �ο����� 3�� �̻��� ���� �˻��Ͽ�
-- �μ���ȣ, �μ��� �ѱ޿��� ��ձ޿��� �˻�, �μ���ȣ�� ����
select * from emp;
select deptno, sum(sal), round(avg(sal), 2), count(*)
from emp
where deptno is not null
group by deptno
having count(*) >= 3
order by deptno;

select round(max(avg(salary)), 2)
from employees
group by department_id;

-- ��ø�� �׷��Լ��� single Į�� ��� ����
--select department_id, max(avg(salary))
--from employees
--group by department_id;

-- �̰� ����
select max(avg(salary))
from employees
group by department_id;


