create table dept80
as select employee_id, last_name, salary*12 ANNSAL, hire_date
from employees
where department_id = 80;

desc dept80;

alter table dept80
add (job_id varchar2(9));

alter table dept80
modify (last_name varchar2(30));

alter table dept80
drop(job_id);

-- set unused
alter table dept80 set unused (hire_date);

alter table dept80 set unused (last_name);

select * from USER_UNUSED_COL_TABS;

alter table dept80 drop unused columns;

-- read only(dml �Ұ�)
alter table dept80 read only;
select * from dept80;

update dept80 set annal = 8000;

drop table dept80; -- read only ���̺��̿��� ���̺� ������ ������

-- rename
create table copy9_emp

rename copy9_emp to real_emp;

select * from real_emp;

rename real_emp to copy9_emp;

-- truncate
select * from copy9_emp;
truncate table copy9_emp;
select * from copy9_emp;
rollback;

-- �ٽ� data ����
insert into copy9_emp
select * from emp;
commit;

-- delete
delete from copy9_emp;
rollback;
select * from copy9_emp;

-- drop
-- purge: ������ �����Ѵٴ� �ǹ�, recycle bean�� ���� ����
-- recycle bean�� �ִ°� ������ �ʹٸ� flashback
drop table copy9_emp purge;

flashback table dept80 to before drop;