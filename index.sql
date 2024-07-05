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
where sal = 5500; --> 안나옴

select * from emp1_v
where ename like '박%';

select * from emp_1
where ename like '박%';

drop view emp1_v;

-- synonym -> 동의어(별명)
create synonym actor for emp_1; --> rename과 다름 , rename은 기존 테이블 이름을 바꿈
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
values(emp_id_seq.nextval, '수지');

select * from emp_1;

select emp_id_seq.currval from dual; --현재 sequence 보는거

insert into emp_1(empno, ename)
values(emp_id_seq.nextval, '아이유');

rollback;

insert into emp_1(empno, ename)
values(emp_id_seq.nextval, '카리나');

-- last_number -> 캐시에 담겨있는 마지막 숫자를 의미
select sequence_name, max_value, increment_by, last_number, cache_size
from user_sequences
where sequence_name = 'EMP_ID_SEQ';

drop sequence emp_id_seq;











