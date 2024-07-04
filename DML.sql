create table test_1
(id number,
name varchar2(20));

insert into test_1 values(11, 'test');

select * from test_1;

insert into test_1 values(13, null);
select * from test_1;

insert into test_1(id, name) values(14, 'test99');

-- �Ͻ��� null
insert into test_1(id) values(15);
select * from test_1;

insert into test_1(id, name) values(&test_id, '&test_name');
select * from test_1;

-- ġȯ ����
select employee_id, last_name
from employees
where employee_id = &employee_num;

select employee_id, last_name, &&column_name
from employees
order by &column_name;

undefine column_name

select employee_id, last_name, &col_name
from employees
order by &col_name;

-- define : && ����
define employee_num = 200
select employee_id, last_name
from employees
where employee_id = &employee_num;

undefine employee_num
select employee_id, last_name
from employees
where employee_id = &employee_num;

create table copy_dept
as select * from departments; -- ���̺� ����
select * from copy_dept;

-- insert
insert into copy_dept(department_id,
department_name, manager_id, location_id)
values(770, 'Public Relations', 100, 1700);
select * from copy_dept;

-- �Ͻ��� null
insert into copy_dept(department_id, department_name) values(330, 'Purchasing');

-- ����� null
insert into copy_dept values(1100, 'Finance', null, null);

-- character type�̳� data type�� ��� ''(empty string) -> null�� �ν���
insert into copy_dept
values(1200, '', null, null);

-- ���̺� ����
drop table test_1;

create table copy_emp
as select * from emp where 1 = 2; -- ���̺� ������ �ʿ��ѵ� �����ʹ� �ʿ���� ��� �̷� ����� �����

insert into copy_emp
select * from emp;

--update
update copy_emp
set sal = 50
where empno = 7788;

-- where �� ���� - ��� ���� ������Ʈ ��
update copy_emp
set sal = 50;

update copy_emp
set job = 'CLERK'
where empno = 7788;

-- ���������� �̿��� ������Ʈ
update copy_emp
set deptno = (select deptno from emp where empno = 7876);

update copy_emp
set job = (select job from emp where empno = 7876)
where ename = 'ALLEN';

--delete
delete from copy_dept
where department_name = 'Public Relations';

select * from copy_dept
where department_name = 'Public Realtions';

delete from copy_dept;-- where ���� ���� ��� ��� �� ����
select * from copy_dept;

-- �ٸ� table���(�������� �̿�) ����
-- �μ� �̸��� ���ڿ� sale�� ���Ե� �μ����� �ٹ��ϴ� ��� ����� ����
delete from copy_emp
where deptno in (select deptno from dept where dname like '%SALE%');

select * from copy_emp;
rollback;
select * from copy_emp;

drop table copy_emp;
drop table copy_dept;
