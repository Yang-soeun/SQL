create table copy_employees
as select * from employees;

create table copy_departments
as select * from departments;

-- commit
delete from copy_employees
where employee_id = 103;

insert into copy_departments values(290, 'Corporate Tax', null, 1700);

commit; -- Ʈ������� �����ϴ� ��ɾ�

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

-- savepoint ����
select * from emp_1;
insert into emp_1 values(601, '������', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_A;

insert into emp_1 values(602, '�̹�ȣ', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_B;

insert into emp_1 values(603, '�����', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_C;

insert into emp_1 values(604, '�ڽ���', 38, 305, to_date('17-DEC-2010', 'DD-MON-YYYY'), 3000, 10);
savepoint test_D;

rollback to savepoint test_B;
rollback to savepoint test_C; -- test_B�� �ѹ��ؼ� test_C�� ���� �Ұ��� ��
rollback to savepoint test_A; -- ����
rollback; -- ���� �� �ѹ� ��




