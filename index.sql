-- index
create table emp_act
(id number(3) primary key using index
(create index emp1_pk_idx on 
emp_act(id)), 
ename varchar2(30), 
loc varchar2(30));

insert into emp_act
select e.empno + 48, e.ename, a.agency_name
from emp_1 e join agency a on(e.agency_id = a.agency_id);

select * from emp_act;

select index_name, table_name, uniqueness
from user_indexes
where table_name = 'emp_act';

select e.ename, a.agency_name
from emp_act e join agency a
on e.loc = a.agency_name
and e.id between 200 and 400;

-- view
-- data dictionary view
select * from user_views;

create or replace view emp1_v as
select empno, ename, agency_id
from emp_1
where agency_id in (10, 30, 50, 60);

select * from emp1_v;

select * from emp1_v
where sal = 5500; --> �ȳ���

select * from emp1_v
where ename like '��%';

select * from emp_1
where ename like '��%';

drop view emp1_v;

-- synonym -> ���Ǿ�(����)
create synonym actor for emp_1; --> rename�� �ٸ� , rename�� ���� ���̺� �̸��� �ٲ�
select * from actor;
select * from user_synonyms;

drop synonym actor;

-- sequence
create sequence emp_id_seq
start with 800
increment by 5
maxvalue 1000;

select emp_id_seq.currval from dual;

select * from emp_1;
insert into emp_1(empno, ename)
values(emp_id_seq.nextval, '����');

select * from emp_1;

select emp_id_seq.currval from dual; --���� sequence ���°�

insert into emp_1(empno, ename)
values(emp_id_seq.nextval, '������');

rollback;

insert into emp_1(empno, ename)
values(emp_id_seq.nextval, 'ī����');

-- last_number -> ĳ�ÿ� ����ִ� ������ ���ڸ� �ǹ�
select sequence_name, max_value, increment_by, last_number, cache_size
from user_sequences
where sequence_name = 'EMP_ID_SEQ';

drop sequence emp_id_seq;











