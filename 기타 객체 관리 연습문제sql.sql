-- 1. 
create table dept1(
id number(7) constraint deparmtent_id primary key,
name varchar2(25));

-- 2.
create sequence dept_id_seq
increment by 10
start with 200
maxvalue 1000;

--3. 
insert into dept1(id, name)
values(dept_id_seq.nextval, 'Education');

insert into dept1
values(dept_id_seq.nextval, 'Administration');

-- 4.
select sequence_name, max_value, increment_by, last_number
from user_sequences;

-- 5.
create synonym empl for employees;
select * from user_synonyms;

-- 6.
drop synonym emp;

-- 7.
create index dept_name_idx on dept1(name);

-- 8.
create table sales_dept(
team_id number(3) primary key using index
(create unique index sales_pk_idx on sales_dept(team_id)),
location varchar2(30)
);

select index_name, table_name, uniqueness
FROM user_indexes
where table_name = 'sales_dept';