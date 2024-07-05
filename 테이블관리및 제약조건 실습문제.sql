-- 1.
create table dept_test(
id number(7) constraint department_id_pk primary key,
name varchar2(25)
);

-- 2.
create table emp_test(
id number(7),
last_name varchar2(25),
first_name varchar2(25),
dept_id number(7)
constraint emp_dept_id_fk references dept_test(id)
);

-- 3.
alter table emp_test add commission number(2, 2);

-- 4.
alter table emp_test
modify (last_name varchar(50));

-- 5,
alter table emp_test
drop column first_name;

-- 6.
alter table emp_test
set unused (dept_id);

-- 7.
alter table emp_test
drop unused columns;

-- 8.
create table employees2
as select employee_id, first_name, last_name, salary, department_id
from employees;

-- 9.
alter table employees2 read only;

-- 10.
alter table employees2
add job_id varchar2(9);

-- 11.
alter table employees2 read write;
alter table employees2
add job_id varchar2(9);


-- 12.
drop table emp_test;
drop table dept_test;
drop table employees2;