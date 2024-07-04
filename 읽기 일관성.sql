-- 읽기 일관성/ 800 -> 999로
select * from copy_emp;
create table copy_emp
as select * from emp;

update copy_emp set sal = 999 where empno = 7369;
commit;

-- lock
select * from copy_employees;
update copy_employees
set salary = 8000
where last_name = 'Grant';
commit;


