create table test_1
(id number,
name varchar2(20));

insert into test_1 values(11, 'test');

select * from test_1;

insert into test_1 values(13, null);
select * from test_1;

insert into test_1(id, name) values(14, 'test99');

-- 암시적 null
insert into test_1(id) values(15);
select * from test_1;

insert into test_1(id, name) values(&test_id, '&test_name');
select * from test_1;

-- 치환 변수
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

-- define : && 동일
define employee_num = 200
select employee_id, last_name
from employees
where employee_id = &employee_num;

undefine employee_num
select employee_id, last_name
from employees
where employee_id = &employee_num;

create table copy_dept
as select * from departments; -- 테이블 복사
select * from copy_dept;

-- insert
insert into copy_dept(department_id,
department_name, manager_id, location_id)
values(770, 'Public Relations', 100, 1700);
select * from copy_dept;

-- 암시적 null
insert into copy_dept(department_id, department_name) values(330, 'Purchasing');

-- 명시적 null
insert into copy_dept values(1100, 'Finance', null, null);

-- character type이나 data type인 경우 ''(empty string) -> null로 인식함
insert into copy_dept
values(1200, '', null, null);

-- 테이블 삭제
drop table test_1;

create table copy_emp
as select * from emp where 1 = 2; -- 테이블 구조는 필요한데 데이터는 필요없는 경우 이런 방식을 사용함

insert into copy_emp
select * from emp;

--update
update copy_emp
set sal = 50
where empno = 7788;

-- where 절 생략 - 모든 행이 업데이트 됨
update copy_emp
set sal = 50;

update copy_emp
set job = 'CLERK'
where empno = 7788;

-- 서브쿼리를 이용한 업데이트
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

delete from copy_dept;-- where 절이 없는 경우 모든 행 삭제
select * from copy_dept;

-- 다른 table기반(서브쿼리 이용) 삭제
-- 부서 이름에 문자열 sale이 포함된 부서에서 근무하는 모든 사원을 삭제
delete from copy_emp
where deptno in (select deptno from dept where dname like '%SALE%');

select * from copy_emp;
rollback;
select * from copy_emp;

drop table copy_emp;
drop table copy_dept;
