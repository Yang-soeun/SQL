create table copy_employees
as select * from employees;

create table copy_departments
as select * from departments;

-- commit
delete from copy_employees
where employee_id = 103;

insert into copy_departments values(290, 'Corporate Tax', null, 1700);

commit; -- 트랜잭션을 종료하는 명령어

-- rollback
delete from copy_employees;
select * from copy_employees;
rollback;
select * from copy_employees;

-- test
delete from copy_employees;
rollback;
delete from copy_employees where employee_id = 101;

select * from copy_employees;
commit;
select * from copy_employees where employee_id = 101;

rollback;
select * from copy_employees where employee_id = 101;

-- savepoint 예제
select * from emp_1;
insert into emp_1 values(601, '유아인', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_A;

insert into emp_1 values(602, '이민호', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_B;

insert into emp_1 values(603, '김고은', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_C;

insert into emp_1 values(604, '박신혜', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_D;

rollback to savepoint test_B;
rollback to savepoint test_C; -- test_B로 롤백해서 test_C는 실행 불가능 함
rollback to savepoint test_A; -- 가능
rollback; -- 전부 다 롤백 됨




