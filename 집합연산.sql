-- ���� ����
--  ù��° select ���� Į������� ����
-- ���Ʒ� ������ �÷��� ������ ���� ���ƾ� �Ѵ�.
-- ���Ʒ� ������ �÷��� ������ Ÿ���� ���� ���ƾ� �Ѵ�
-- order by ���� �� �Ʒ� �������� ����� �� �ֵ�.
-- �÷��� ��Ī�� �� ���� ������ �÷����� ����� �� �ִ�.
select deptno from emp 
union all -- �ߺ���� ������
select deptno from dept
order by deptno;

select deptno from emp
union -- �ߺ����� ������
select deptno from dept;

select deptno from emp
intersect -- ������
select deptno from dept;

select deptno from emp
minus -- ������
select deptno from dept;

select deptno from dept
minus 
select deptno from emp;

-- Į�� ���� ���߱� alias �࿩��
select ename, null as dname from emp
union all
select dname, null from dept
union all
select null, 'KOREA' from dual;

-- table�� ���� comment���� ����
select * from user_tab_comments
where table_name = 'JOB_HISTORY';

desc job_history;

-- �� Į���� ���� comment�� Ȯ�� ����
select * from user_col_comments 
where table_name = 'JOB_HISTORY';

-- ���̺� ����
select * from user_tables;

-- ���� �����丮
select * from job_history;

-- Į�� �ڸ��� ���߱�
select location_id, null city, department_name
from departments
union
select location_id, city, null
from locations;


-- ����
-- emp���� sal ���� ������ ���ؼ� �Ʒ��� ����� ����Ͻÿ�!
select 1, sal
from emp;

select '��ü��Ż : ', sum(sal)
from emp;

select job, sum(sal)
from emp
group by job
union all
select '��ü��Ż: ' , sum(sal)
from emp;

select * from emp;

select to_char(hiredate, 'YYYY') as "�Ի� �⵵", 
sum(sal) as "���� �հ�"
from emp
group by to_char(hiredate, 'YYYY')
union all
select '��ü��Ż : ', sum(sal)
from emp
order by 1;


